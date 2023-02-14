//************************************************************************
// Copyright 2022 Massachusetts Institute of Technology
//
// This file is auto-generated for test: RSA. Do not modify!!!
//
// Generated on: Feb 14 2023 13:54:50
//************************************************************************
#ifndef RSA_playback_H
#define RSA_playback_H

#ifndef PLAYBACK_CMD_H
#define PLAYBACK_CMD_H
// Write to : <physicalAdr> <writeData>
#define WRITE__CMD  1
// Read and compare: <physicalAdr> <Data2Compare>
#define RDnCMP_CMD  2
// Read and spin until match : <physicalAdr> <Data2Match> <mask> <timeout>
#define RDSPIN_CMD  3

#define WRITE__CMD_SIZE  3
#define RDnCMP_CMD_SIZE  3
#define RDSPIN_CMD_SIZE  5
#endif

// RSA command sequences to playback
uint64_t RSA_playback[] = { 
	  WRITE__CMD, 0x70030018, 0x0000000000000004 // 1
	, WRITE__CMD, 0x70030018, 0x0000000000000000 // 2
	, WRITE__CMD, 0x70030010, 0x0000000000000011 // 3
	, WRITE__CMD, 0x70030018, 0x0000000000000003 // 4
	, WRITE__CMD, 0x70030018, 0x0000000000000000 // 5
	, WRITE__CMD, 0x70030058, 0x0000000000000005 // 6
	, WRITE__CMD, 0x70030030, 0x0000000000000004 // 7
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 8
	, WRITE__CMD, 0x70030028, 0x0000000000000000 // 9
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 10
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 11
	, WRITE__CMD, 0x70030028, 0x00000000a95341a5 // 12
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 13
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 14
	, WRITE__CMD, 0x70030050, 0x0000000000000002 // 15
	, WRITE__CMD, 0x70030048, 0x0000000000000004 // 16
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 17
	, WRITE__CMD, 0x70030040, 0x0000000000000000 // 18
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 19
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 20
	, WRITE__CMD, 0x70030040, 0x00000000ffffff7f // 21
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 22
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 23
	, WRITE__CMD, 0x70030000, 0x0000000000000002 // 24
	, WRITE__CMD, 0x70030000, 0x0000000000000000 // 25
	, RDSPIN_CMD, 0x70030000, 0x0000000000000001, 0xffffffffffffffff, 0x9c40 // 26
	, WRITE__CMD, 0x70030070, 0x0000000000000002 // 27
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 28
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 29
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 30
	, RDnCMP_CMD, 0x70030068, 0x0000000000000000 // 31
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 32
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 33
	, RDnCMP_CMD, 0x70030068, 0x0000000026e2bf00 // 34
	, WRITE__CMD, 0x70030018, 0x0000000000000004 // 35
	, WRITE__CMD, 0x70030018, 0x0000000000000000 // 36
	, WRITE__CMD, 0x70030010, 0x0000000000000011 // 37
	, WRITE__CMD, 0x70030018, 0x0000000000000003 // 38
	, WRITE__CMD, 0x70030018, 0x0000000000000000 // 39
	, WRITE__CMD, 0x70030058, 0x0000000000000005 // 40
	, WRITE__CMD, 0x70030030, 0x0000000000000004 // 41
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 42
	, WRITE__CMD, 0x70030028, 0x0000000000000000 // 43
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 44
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 45
	, WRITE__CMD, 0x70030028, 0x00000000bbc2b406 // 46
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 47
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 48
	, WRITE__CMD, 0x70030028, 0x000000004728ef15 // 49
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 50
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 51
	, WRITE__CMD, 0x70030050, 0x0000000000000003 // 52
	, WRITE__CMD, 0x70030048, 0x0000000000000004 // 53
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 54
	, WRITE__CMD, 0x70030040, 0x0000000000000000 // 55
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 56
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 57
	, WRITE__CMD, 0x70030040, 0x00000000a7d068e9 // 58
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 59
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 60
	, WRITE__CMD, 0x70030040, 0x000000008178f9fb // 61
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 62
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 63
	, WRITE__CMD, 0x70030000, 0x0000000000000002 // 64
	, WRITE__CMD, 0x70030000, 0x0000000000000000 // 65
	, RDSPIN_CMD, 0x70030000, 0x0000000000000001, 0xffffffffffffffff, 0xea60 // 66
	, WRITE__CMD, 0x70030070, 0x0000000000000002 // 67
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 68
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 69
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 70
	, RDnCMP_CMD, 0x70030068, 0x0000000000000000 // 71
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 72
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 73
	, RDnCMP_CMD, 0x70030068, 0x000000003b197ce1 // 74
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 75
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 76
	, RDnCMP_CMD, 0x70030068, 0x00000000cfb622e6 // 77
	, WRITE__CMD, 0x70030018, 0x0000000000000004 // 78
	, WRITE__CMD, 0x70030018, 0x0000000000000000 // 79
	, WRITE__CMD, 0x70030010, 0x0000000000000011 // 80
	, WRITE__CMD, 0x70030018, 0x0000000000000003 // 81
	, WRITE__CMD, 0x70030018, 0x0000000000000000 // 82
	, WRITE__CMD, 0x70030058, 0x0000000000000005 // 83
	, WRITE__CMD, 0x70030030, 0x0000000000000004 // 84
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 85
	, WRITE__CMD, 0x70030028, 0x0000000000000000 // 86
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 87
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 88
	, WRITE__CMD, 0x70030028, 0x00000000a6a25b1b // 89
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 90
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 91
	, WRITE__CMD, 0x70030050, 0x0000000000000002 // 92
	, WRITE__CMD, 0x70030048, 0x0000000000000004 // 93
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 94
	, WRITE__CMD, 0x70030040, 0x0000000000000000 // 95
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 96
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 97
	, WRITE__CMD, 0x70030040, 0x00000000ffffff7f // 98
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 99
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 100
	, WRITE__CMD, 0x70030000, 0x0000000000000002 // 101
	, WRITE__CMD, 0x70030000, 0x0000000000000000 // 102
	, RDSPIN_CMD, 0x70030000, 0x0000000000000001, 0xffffffffffffffff, 0x9c40 // 103
	, WRITE__CMD, 0x70030070, 0x0000000000000002 // 104
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 105
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 106
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 107
	, RDnCMP_CMD, 0x70030068, 0x0000000000000000 // 108
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 109
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 110
	, RDnCMP_CMD, 0x70030068, 0x000000003039793d // 111
	, WRITE__CMD, 0x70030018, 0x0000000000000004 // 112
	, WRITE__CMD, 0x70030018, 0x0000000000000000 // 113
	, WRITE__CMD, 0x70030010, 0x0000000000000011 // 114
	, WRITE__CMD, 0x70030018, 0x0000000000000003 // 115
	, WRITE__CMD, 0x70030018, 0x0000000000000000 // 116
	, WRITE__CMD, 0x70030058, 0x0000000000000005 // 117
	, WRITE__CMD, 0x70030030, 0x0000000000000004 // 118
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 119
	, WRITE__CMD, 0x70030028, 0x0000000000000000 // 120
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 121
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 122
	, WRITE__CMD, 0x70030028, 0x00000000dddcee79 // 123
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 124
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 125
	, WRITE__CMD, 0x70030028, 0x00000000ab1515cb // 126
	, WRITE__CMD, 0x70030030, 0x0000000000000003 // 127
	, WRITE__CMD, 0x70030030, 0x0000000000000000 // 128
	, WRITE__CMD, 0x70030050, 0x0000000000000003 // 129
	, WRITE__CMD, 0x70030048, 0x0000000000000004 // 130
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 131
	, WRITE__CMD, 0x70030040, 0x0000000000000000 // 132
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 133
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 134
	, WRITE__CMD, 0x70030040, 0x000000001f193ae0 // 135
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 136
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 137
	, WRITE__CMD, 0x70030040, 0x000000000206190c // 138
	, WRITE__CMD, 0x70030048, 0x0000000000000003 // 139
	, WRITE__CMD, 0x70030048, 0x0000000000000000 // 140
	, WRITE__CMD, 0x70030000, 0x0000000000000002 // 141
	, WRITE__CMD, 0x70030000, 0x0000000000000000 // 142
	, RDSPIN_CMD, 0x70030000, 0x0000000000000001, 0xffffffffffffffff, 0xea60 // 143
	, WRITE__CMD, 0x70030070, 0x0000000000000002 // 144
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 145
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 146
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 147
	, RDnCMP_CMD, 0x70030068, 0x0000000000000000 // 148
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 149
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 150
	, RDnCMP_CMD, 0x70030068, 0x000000005695b65c // 151
	, WRITE__CMD, 0x70030070, 0x0000000000000001 // 152
	, WRITE__CMD, 0x70030070, 0x0000000000000000 // 153
	, RDnCMP_CMD, 0x70030068, 0x00000000cb91c7c2 // 154
};

#define RSA_adrBase 0x0070030000
#define RSA_adrSize 0x10000
#define RSA_cmdCnt4Single 77
#define RSA_totalCommands 154
#endif
