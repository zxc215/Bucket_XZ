/*
Copyright 2013-present Barefoot Networks, Inc. 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

header_type ethernet_t {
    fields {
		mac_empty : 96;
        //dstAddr : 48;
        //srcAddr : 48;
        etherType : 16;
    }
}

header_type ipv4_t {
    fields {
		ip_empty : 72;
        //version : 4;
        //ihl : 4;
        //diffserv : 8;
        //totalLen : 16;
        //identification : 16;
        //flags : 3;
        //fragOffset : 13;
        //ttl : 8;
        protocol : 8;
        hdrChecksum : 16;
        srcAddr : 32;
        dstAddr: 32;
    }
}

//header_type tcp_t {
//    fields {
//        srcPort : 16;
//        dstPort : 16;
//        seqNo : 32;
//        ackNo : 32;
//        dataOffset : 4;
//        res : 4;
//        flags : 8;
//        window : 16;
//        checksum : 16;
//        urgentPtr : 16;
//    }
//}

header_type udp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
		udp_empty : 32;
        //length_ : 16;
        //checksum : 16;
    }
}

// Metadata to hold port numbers for both TCP and UDP
//header_type l4_t {
//    fields {
//        sport: 16;
//        dport: 16;
//    }
//}

//metadata l4_t l4;

header_type Ftuple_t {
		fields {
				tuples: 96;
		}
}

metadata Ftuple_t Ftuple;
