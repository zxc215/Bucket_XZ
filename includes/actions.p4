/*
Copyright 2017-present New York University 

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

action _nop() {
}

action _drop() {
		drop();
}



// Write TCP port numbers to metadata
//action set_tcp_ports() {
//    modify_field(l4.sport, tcp.srcPort);
//    modify_field(l4.dport, tcp.dstPort);
//}

// Write UDP port numbers to metadata
//action set_udp_ports() {
//    modify_field(l4.sport, udp.srcPort);
//    modify_field(l4.dport, udp.dstPort);
//}

action load_up() {
		modify_field(Ftuple.tuples,ipv4.srcAddr);
		modify_field(Ftuple.tuples,Ftuple.tuples << 32);
		add_to_field(Ftuple.tuples,ipv4.dstAddr);
		modify_field(Ftuple.tuples,Ftuple.tuples << 16);
		add_to_field(Ftuple.tuples,udp.srcPort);
		modify_field(Ftuple.tuples,Ftuple.tuples << 16);
		add_to_field(Ftuple.tuples,udp.dstPort);
}

action up_call(buffer_port) {
		generate_digest(0,copy_to_cpu_fields);
		modify_field(standard_metadata.egress_spec, buffer_port);
}

field_list copy_to_cpu_fields {
		Ftuple.tuples;
}
action send_out(outport) {
		modify_field(standard_metadata.egress_spec, outport);
}


