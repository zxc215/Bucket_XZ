#include "includes/headers.p4"
#include "includes/parser.p4"
#include "includes/actions.p4"

table load_meta {
		reads {
			ethernet.etherType : exact;	
		}
		actions {
				load_up;
		}
}

table table1 {
		reads {
				Ftuple.tuples: ternary;
		}
		actions {
				up_call;
				_nop;
				_drop;
		}
}

table table2 {
		reads {
				Ftuple.tuples : ternary;
		}
		actions {
				send_out;
				_drop;
				_nop;
		}
}

control ingress {
		apply(load_meta);
		apply(table1);
		apply(table2);
}

control egress {
}

