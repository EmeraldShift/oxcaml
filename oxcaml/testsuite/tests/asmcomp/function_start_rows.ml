(* TEST
 flags = "-g -S";
 arch_amd64;
 probes;
 native;
*)

(* [function_start_rows.run] prints the line of the row at each function's
   first instruction, or "none" if there is no row there. Functions without a
   line get line 0, and the probe wrapper gets its probe's line. *)

let[@inline never] [@local never] located x = (x * 3) + 1

# 0 "function_start_rows.ml"
let[@inline never] [@local never] without_line x = (x * 5) + 7
# 17 "function_start_rows.ml"

let[@inline never] [@local never] with_probe x =
  [%probe "function_start_rows" (ignore (Sys.opaque_identity (located x)))];
  x + 2

let () =
  ignore (Sys.opaque_identity (without_line (with_probe (Sys.opaque_identity 4))))
