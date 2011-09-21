//===-- ARMInstPrinter.h - Convert ARM MCInst to assembly syntax ----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This class prints an ARM MCInst to a .s file.
//
//===----------------------------------------------------------------------===//

#ifndef ARMINSTPRINTER_H
#define ARMINSTPRINTER_H

#include "llvm/MC/MCInstPrinter.h"
#include "llvm/MC/MCSubtargetInfo.h"

namespace llvm {

class MCOperand;

class ARMInstPrinter : public MCInstPrinter {
public:
    ARMInstPrinter(const MCAsmInfo &MAI, const MCSubtargetInfo &STI);

  virtual void printInst(const MCInst *MI, raw_ostream &O, StringRef Annot);
  virtual StringRef getOpcodeName(unsigned Opcode) const;
  virtual void printRegName(raw_ostream &OS, unsigned RegNo) const;

  static const char *getInstructionName(unsigned Opcode);

  // Autogenerated by tblgen.
  void printInstruction(const MCInst *MI, raw_ostream &O);
  static const char *getRegisterName(unsigned RegNo);


  void printOperand(const MCInst *MI, unsigned OpNo, raw_ostream &O);

  void printSORegRegOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printSORegImmOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);

  void printAddrModeTBB(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAddrModeTBH(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAddrMode2Operand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAM2PostIndexOp(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAM2PreOrOffsetIndexOp(const MCInst *MI, unsigned OpNum,
                                  raw_ostream &O);
  void printAddrMode2OffsetOperand(const MCInst *MI, unsigned OpNum,
                                   raw_ostream &O);

  void printAddrMode3Operand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAddrMode3OffsetOperand(const MCInst *MI, unsigned OpNum,
                                   raw_ostream &O);
  void printAM3PostIndexOp(const MCInst *MI, unsigned Op, raw_ostream &O);
  void printAM3PreOrOffsetIndexOp(const MCInst *MI, unsigned Op,raw_ostream &O);
  void printPostIdxImm8Operand(const MCInst *MI, unsigned OpNum,
                               raw_ostream &O);
  void printPostIdxRegOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printPostIdxImm8s4Operand(const MCInst *MI, unsigned OpNum,
                               raw_ostream &O);

  void printLdStmModeOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAddrMode5Operand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAddrMode6Operand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAddrMode7Operand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAddrMode6OffsetOperand(const MCInst *MI, unsigned OpNum,
                                   raw_ostream &O);

  void printBitfieldInvMaskImmOperand(const MCInst *MI, unsigned OpNum,
                                      raw_ostream &O);
  void printMemBOption(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printShiftImmOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printPKHLSLShiftImm(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printPKHASRShiftImm(const MCInst *MI, unsigned OpNum, raw_ostream &O);

  void printThumbS4ImmOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printThumbSRImm(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printThumbITMask(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printThumbAddrModeRROperand(const MCInst *MI, unsigned OpNum,
                                   raw_ostream &O);
  void printThumbAddrModeImm5SOperand(const MCInst *MI, unsigned OpNum,
                                      raw_ostream &O, unsigned Scale);
  void printThumbAddrModeImm5S1Operand(const MCInst *MI, unsigned OpNum,
                                       raw_ostream &O);
  void printThumbAddrModeImm5S2Operand(const MCInst *MI, unsigned OpNum,
                                       raw_ostream &O);
  void printThumbAddrModeImm5S4Operand(const MCInst *MI, unsigned OpNum,
                                       raw_ostream &O);
  void printThumbAddrModeSPOperand(const MCInst *MI, unsigned OpNum,
                                   raw_ostream &O);

  void printT2SOOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printAddrModeImm12Operand(const MCInst *MI, unsigned OpNum,
                                 raw_ostream &O);
  void printT2AddrModeImm8Operand(const MCInst *MI, unsigned OpNum,
                                  raw_ostream &O);
  void printT2AddrModeImm8s4Operand(const MCInst *MI, unsigned OpNum,
                                    raw_ostream &O);
  void printT2AddrModeImm0_1020s4Operand(const MCInst *MI, unsigned OpNum,
                                    raw_ostream &O);
  void printT2AddrModeImm8OffsetOperand(const MCInst *MI, unsigned OpNum,
                                        raw_ostream &O);
  void printT2AddrModeImm8s4OffsetOperand(const MCInst *MI, unsigned OpNum,
                                          raw_ostream &O);
  void printT2AddrModeSoRegOperand(const MCInst *MI, unsigned OpNum,
                                   raw_ostream &O);

  void printSetendOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printCPSIMod(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printCPSIFlag(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printMSRMaskOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printPredicateOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printMandatoryPredicateOperand(const MCInst *MI, unsigned OpNum,
                                      raw_ostream &O);
  void printSBitModifierOperand(const MCInst *MI, unsigned OpNum,
                                raw_ostream &O);
  void printRegisterList(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printNoHashImmediate(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printPImmediate(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printCImmediate(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printVFPf32ImmOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printVFPf64ImmOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printNEONModImmOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printImmPlusOneOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printRotImmOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);

  void printPCLabel(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printT2LdrLabelOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
  void printT2AdrLabelOperand(const MCInst *MI, unsigned OpNum, raw_ostream &O);
};

} // end namespace llvm

#endif
