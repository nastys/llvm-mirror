//=- WebAssemblyMCCodeEmitter.cpp - Convert WebAssembly code to machine code -//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// \brief This file implements the WebAssemblyMCCodeEmitter class.
///
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/WebAssemblyMCTargetDesc.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/MC/MCCodeEmitter.h"
#include "llvm/MC/MCFixup.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/Support/EndianStream.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

#define DEBUG_TYPE "mccodeemitter"

STATISTIC(MCNumEmitted, "Number of MC instructions emitted.");
STATISTIC(MCNumFixups, "Number of MC fixups created.");

namespace {
class WebAssemblyMCCodeEmitter final : public MCCodeEmitter {
  const MCInstrInfo &MCII;

  // Implementation generated by tablegen.
  uint64_t getBinaryCodeForInstr(const MCInst &MI,
                                 SmallVectorImpl<MCFixup> &Fixups,
                                 const MCSubtargetInfo &STI) const;

  void encodeInstruction(const MCInst &MI, raw_ostream &OS,
                         SmallVectorImpl<MCFixup> &Fixups,
                         const MCSubtargetInfo &STI) const override;

public:
  WebAssemblyMCCodeEmitter(const MCInstrInfo &mcii) : MCII(mcii) {}
};
} // end anonymous namespace

MCCodeEmitter *llvm::createWebAssemblyMCCodeEmitter(const MCInstrInfo &MCII) {
  return new WebAssemblyMCCodeEmitter(MCII);
}

void WebAssemblyMCCodeEmitter::encodeInstruction(
    const MCInst &MI, raw_ostream &OS, SmallVectorImpl<MCFixup> &Fixups,
    const MCSubtargetInfo &STI) const {
  // FIXME: This is not the real binary encoding. This is an extremely
  // over-simplified encoding where we just use uint64_t for everything. This
  // is a temporary measure.
  support::endian::Writer<support::little>(OS).write<uint64_t>(MI.getOpcode());
  const MCInstrDesc &Desc = MCII.get(MI.getOpcode());
  if (Desc.isVariadic())
    support::endian::Writer<support::little>(OS).write<uint64_t>(
        MI.getNumOperands() - Desc.NumOperands);
  for (unsigned i = 0, e = MI.getNumOperands(); i < e; ++i) {
    const MCOperand &MO = MI.getOperand(i);
    if (MO.isReg()) {
      support::endian::Writer<support::little>(OS).write<uint64_t>(MO.getReg());
    } else if (MO.isImm()) {
      support::endian::Writer<support::little>(OS).write<uint64_t>(MO.getImm());
    } else if (MO.isFPImm()) {
      support::endian::Writer<support::little>(OS).write<double>(MO.getFPImm());
    } else if (MO.isExpr()) {
      support::endian::Writer<support::little>(OS).write<uint64_t>(0);
      Fixups.push_back(MCFixup::create(
          (1 + MCII.get(MI.getOpcode()).isVariadic() + i) * sizeof(uint64_t),
          MO.getExpr(),
          STI.getTargetTriple().isArch64Bit() ? FK_Data_8 : FK_Data_4,
          MI.getLoc()));
      ++MCNumFixups;
    } else {
      llvm_unreachable("unexpected operand kind");
    }
  }

  ++MCNumEmitted; // Keep track of the # of mi's emitted.
}

#include "WebAssemblyGenMCCodeEmitter.inc"
