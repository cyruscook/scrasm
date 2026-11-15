(module
 (type $Array (sub (array (mut (ref eq)))))
 (rec
  (type $Func_1 (func (param (ref eq) (ref $Env)) (result i32 (ref eq))))
  (type $Env (sub (struct (field (mut i8)) (field (mut (ref $Func_1))))))
 )
 (type $String (sub (array (mut i8))))
 (type $Func_2 (func (param (ref eq) (ref eq) (ref $Env)) (result i32 (ref eq))))
 (type $C_import_func_VV_V (func (param (ref eq) (ref eq)) (result (ref eq))))
 (type $C_import_func_V_V (func (param (ref eq)) (result (ref eq))))
 (type $Gen_closure_1 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))))))
 (type $Closure_1_0 (sub $Gen_closure_1 (struct (field (mut i8)) (field (mut (ref $Func_1))))))
 (type $Gen_closure_2 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Func_2))))))
 (type $Closure_2_0 (sub $Gen_closure_2 (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Func_2))))))
 (type $Int64 (sub (struct (field (mut i64)))))
 (type $Float (sub (struct (field (mut f64)))))
 (type $Partial_closure_2_1 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Gen_closure_2))) (field (mut (ref eq))))))
 (type $Func_3 (func (param (ref eq) (ref eq) (ref eq) (ref $Env)) (result i32 (ref eq))))
 (type $Gen_closure_3 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Func_3))))))
 (type $Partial_closure_3_2 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Gen_closure_3))) (field (mut (ref eq))) (field (mut (ref eq))))))
 (type $Partial_closure_3_1 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Gen_closure_3))) (field (mut (ref eq))))))
 (type $Closure_3_0 (sub $Gen_closure_3 (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Func_3))))))
 (type $Func_4 (func (param (ref eq) (ref eq) (ref eq) (ref eq) (ref $Env)) (result i32 (ref eq))))
 (type $Gen_closure_4 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Func_4))))))
 (type $Closure_1_2 (sub $Gen_closure_1 (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref eq))) (field (mut (ref eq))))))
 (type $22 (func))
 (type $C_import_func_VVV_V (func (param (ref eq) (ref eq) (ref eq)) (result (ref eq))))
 (type $FloatArray (sub (array (mut f64))))
 (type $Closure_4_0 (sub $Gen_closure_4 (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Func_4))))))
 (type $Closure_2_1 (sub $Gen_closure_2 (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Func_2))) (field (mut (ref eq))))))
 (type $Partial_closure_4_3 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Gen_closure_4))) (field (mut (ref eq))) (field (mut (ref eq))) (field (mut (ref eq))))))
 (type $28 (func (param f64) (result f64)))
 (type $Partial_closure_4_2 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Gen_closure_4))) (field (mut (ref eq))) (field (mut (ref eq))))))
 (type $Closure_1_3 (sub $Gen_closure_1 (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref eq))) (field (mut (ref eq))) (field (mut (ref eq))))))
 (type $Partial_closure_4_1 (sub $Env (struct (field (mut i8)) (field (mut (ref $Func_1))) (field (mut (ref $Gen_closure_4))) (field (mut (ref eq))))))
 (type $C_import_func_VVVV_V (func (param (ref eq) (ref eq) (ref eq) (ref eq)) (result (ref eq))))
 (type $33 (func (param f64 f64) (result f64)))
 (type $C_import_func_VVVVV_V (func (param (ref eq) (ref eq) (ref eq) (ref eq) (ref eq)) (result (ref eq))))
 (type $35 (func (param (ref $String) (ref $String)) (result i32)))
 (type $Set_of_closures_Taku.51 (sub (struct (field (mut (ref $Closure_1_0))) (field (mut (ref $Closure_3_0))))))
 (type $37 (func (param (ref eq) (ref eq)) (result (ref i31))))
 (type $38 (func (param i32)))
 (type $39 (func (param (ref $Array) (ref $Array)) (result (ref i31))))
 (type $40 (func (param (ref $FloatArray) (ref eq)) (result (ref $Float))))
 (type $41 (func (param (ref $Array) (ref eq)) (result (ref eq))))
 (type $42 (func (param f64)))
 (type $43 (func (param (ref $String))))
 (type $44 (func (param (ref eq)) (result (ref $Float))))
 (type $C_import_func_6_F (func (param i64) (result f64)))
 (type $46 (func (param (ref $String) i32 i32 i32)))
 (type $47 (func (param f64) (result (ref eq))))
 (type $48 (func (param i32) (result (ref eq))))
 (type $49 (func (param (ref eq) (ref eq)) (result (ref $Array))))
 (import "js_runtime" "print_endline" (func $print_endline (type $22)))
 (import "js_runtime" "print_i32" (func $print_i32 (type $38) (param i32)))
 (import "js_runtime" "print_f64" (func $print_f64 (type $42) (param f64)))
 (import "js_runtime" "putchar" (func $putchar (type $38) (param i32)))
 (import "js_runtime" "flush" (func $flush (type $22)))
 (import "js_runtime" "atan2" (func $atan2 (type $33) (param f64 f64) (result f64)))
 (import "js_runtime" "sin" (func $sin (type $28) (param f64) (result f64)))
 (import "js_runtime" "asin" (func $asin (type $28) (param f64) (result f64)))
 (import "js_runtime" "cos" (func $cos (type $28) (param f64) (result f64)))
 (import "js_runtime" "fmod" (func $fmod (type $33) (param f64 f64) (result f64)))
 (global $camlCamlinternalFormatBasics__concat_fmt_185_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2)
  (ref.func $concat_fmt_185)
 ))
 (global $camlStdlib__Pccall_1851 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlCamlinternalFormatBasics__erase_rel_11_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $erase_rel_11)
 ))
 (global $camlCamlinternalFormatBasics__concat_fmtty_97_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2)
  (ref.func $concat_fmtty_97)
 ))
 (global $camlStdlib__Pccall_1850 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib__output_string_763_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $output_string_763)
 ))
 (global $invalid_argument (ref eq) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 248)
  )
  (array.new_fixed $String 3
   (i32.const 78)
   (i32.const 78)
   (i32.const 78)
  )
  (ref.i31
   (i32.const 2)
  )
 ))
 (global $camlStdlib__exit_function_1810 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlTaku__tak_43_closure (ref $Closure_3_0) (struct.new $Closure_3_0
  (i32.const 3)
  (ref.func $Caml_curry_3_321)
  (ref.func $tak_43)
 ))
 (global $camlStdlib__input_line_1015_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $input_line_1015)
 ))
 (global $camlStdlib__Pccall_1852 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib__^_456_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $^_456)
 ))
 (global $camlCamlinternalAtomic__compare_and_set_59_closure (ref $Closure_3_0) (struct.new $Closure_3_0
  (i32.const 3)
  (ref.func $Caml_curry_3)
  (ref.func $compare_and_set_59)
 ))
 (global $camlStdlib__valid_float_lexem_566_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $valid_float_lexem_566)
 ))
 (global $camlStdlib__unsafe_really_input_942_closure (ref $Closure_4_0) (struct.new $Closure_4_0
  (i32.const 4)
  (ref.func $Caml_curry_4)
  (ref.func $unsafe_really_input_942)
 ))
 (global $global$2 (ref eq) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 248)
  )
  (array.new_fixed $String 3
   (i32.const 78)
   (i32.const 78)
   (i32.const 78)
  )
  (ref.i31
   (i32.const 3)
  )
 ))
 (global $camlStdlib__open_out_gen_669_closure (ref $Closure_3_0) (struct.new $Closure_3_0
  (i32.const 3)
  (ref.func $Caml_curry_3_170)
  (ref.func $open_out_gen_669)
 ))
 (global $camlStdlib__output_bytes_751_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $output_bytes_751)
 ))
 (global $camlStdlib__open_in_gen_869_closure (ref $Closure_3_0) (struct.new $Closure_3_0
  (i32.const 3)
  (ref.func $Caml_curry_3_170)
  (ref.func $open_in_gen_869)
 ))
 (global $camlStdlib__at_exit_1395_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $at_exit_1395)
 ))
 (global $camlCamlinternalAtomic__fetch_and_add_75_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_153)
  (ref.func $fetch_and_add_75)
 ))
 (global $camlStdlib__const_immstring_542 (ref $String) (array.new_fixed $String 2
  (i32.const 37)
  (i32.const 100)
 ))
 (global $camlStdlib__build_result_1021_closure (ref $Closure_3_0) (struct.new $Closure_3_0
  (i32.const 3)
  (ref.func $Caml_curry_3_170)
  (ref.func $build_result_1021)
 ))
 (global $camlTaku__repeat_49_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_321)
  (ref.func $repeat_49)
 ))
 (global $global$7 (ref eq) (ref.i31
  (i32.const 8)
 ))
 (global $camlStdlib__int_of_string_opt_548_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $int_of_string_opt_548)
 ))
 (global $camlStdlib__float_of_string_opt_624_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $float_of_string_opt_624)
 ))
 (global $camlStdlib____642_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $__642)
 ))
 (global $camlStdlib__flush_all_715_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $flush_all_715)
 ))
 (global $camlStdlib__do_at_exit_1448_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $do_at_exit_1448)
 ))
 (global $camlStdlib__const_immstring_616 (ref $String) (array.new_fixed $String 5
  (i32.const 37)
  (i32.const 46)
  (i32.const 49)
  (i32.const 50)
  (i32.const 103)
 ))
 (global $camlStdlib__iter_721_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $iter_721)
 ))
 (global $global$6 (ref eq) (ref.i31
  (i32.const 7)
 ))
 (global $camlStdlib__failwith_323_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $failwith_323)
 ))
 (global $camlStdlib__invalid_arg_334_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $invalid_arg_334)
 ))
 (global $camlStdlib__min_378_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $min_378)
 ))
 (global $camlStdlib__max_387_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $max_387)
 ))
 (global $camlStdlib__abs_396_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $abs_396)
 ))
 (global $camlStdlib__lnot_407_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $lnot_407)
 ))
 (global $camlStdlib__char_of_int_481_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $char_of_int_481)
 ))
 (global $camlStdlib__string_of_bool_501_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $string_of_bool_501)
 ))
 (global $camlStdlib__bool_of_string_512_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $bool_of_string_512)
 ))
 (global $camlStdlib__bool_of_string_opt_526_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $bool_of_string_opt_526)
 ))
 (global $camlStdlib__string_of_int_538_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $string_of_int_538)
 ))
 (global $camlStdlib__string_of_float_611_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $string_of_float_611)
 ))
 (global $camlStdlib__open_out_683_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $open_out_683)
 ))
 (global $camlStdlib__open_out_bin_699_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $open_out_bin_699)
 ))
 (global $camlStdlib__output_775_closure (ref $Closure_4_0) (struct.new $Closure_4_0
  (i32.const 4)
  (ref.func $Caml_curry_4)
  (ref.func $output_775)
 ))
 (global $camlStdlib__output_substring_806_closure (ref $Closure_4_0) (struct.new $Closure_4_0
  (i32.const 4)
  (ref.func $Caml_curry_4)
  (ref.func $output_substring_806)
 ))
 (global $camlStdlib__output_value_837_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $output_value_837)
 ))
 (global $camlStdlib__close_out_847_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $close_out_847)
 ))
 (global $camlStdlib__close_out_noerr_856_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $close_out_noerr_856)
 ))
 (global $camlStdlib__open_in_883_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $open_in_883)
 ))
 (global $camlStdlib__open_in_bin_897_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $open_in_bin_897)
 ))
 (global $camlStdlib__input_911_closure (ref $Closure_4_0) (struct.new $Closure_4_0
  (i32.const 4)
  (ref.func $Caml_curry_4)
  (ref.func $input_911)
 ))
 (global $camlStdlib__really_input_969_closure (ref $Closure_4_0) (struct.new $Closure_4_0
  (i32.const 4)
  (ref.func $Caml_curry_4)
  (ref.func $really_input_969)
 ))
 (global $camlStdlib__really_input_string_1001_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $really_input_string_1001)
 ))
 (global $camlStdlib__close_in_noerr_1127_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $close_in_noerr_1127)
 ))
 (global $camlStdlib__string_of_format_1354_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $string_of_format_1354)
 ))
 (global $camlStdlib__^^_1361_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $^^_1361)
 ))
 (global $camlStdlib__anon_fn_1593_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $anon_fn_1593)
 ))
 (global $camlStdlib__anon_fn_1587_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1587)
 ))
 (global $camlStdlib__anon_fn_1581_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1581)
 ))
 (global $camlStdlib__anon_fn_1575_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1575)
 ))
 (global $camlStdlib__anon_fn_1568_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $anon_fn_1568)
 ))
 (global $camlStdlib__anon_fn_1562_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1562)
 ))
 (global $camlStdlib__anon_fn_1556_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1556)
 ))
 (global $camlStdlib__anon_fn_1550_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1550)
 ))
 (global $camlStdlib__anon_fn_1544_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1544)
 ))
 (global $camlStdlib__anon_fn_1537_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $anon_fn_1537)
 ))
 (global $camlStdlib__anon_fn_1531_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1531)
 ))
 (global $camlStdlib__anon_fn_1525_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1525)
 ))
 (global $camlStdlib__anon_fn_1518_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $anon_fn_1518)
 ))
 (global $camlStdlib__anon_fn_1511_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $anon_fn_1511)
 ))
 (global $camlStdlib__anon_fn_1504_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $anon_fn_1504)
 ))
 (global $camlStdlib__anon_fn_1497_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $anon_fn_1497)
 ))
 (global $camlStdlib__anon_fn_1491_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1491)
 ))
 (global $camlStdlib__print_char_1136_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $print_char_1136)
 ))
 (global $camlStdlib__print_string_1144_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $print_string_1144)
 ))
 (global $camlStdlib__print_bytes_1153_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $print_bytes_1153)
 ))
 (global $camlStdlib__print_int_1162_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $print_int_1162)
 ))
 (global $camlStdlib__print_float_1174_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $print_float_1174)
 ))
 (global $camlStdlib__print_endline_1186_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $print_endline_1186)
 ))
 (global $camlStdlib__print_newline_1201_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $print_newline_1201)
 ))
 (global $camlStdlib__prerr_char_1213_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $prerr_char_1213)
 ))
 (global $camlStdlib__prerr_string_1221_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $prerr_string_1221)
 ))
 (global $camlStdlib__prerr_bytes_1230_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $prerr_bytes_1230)
 ))
 (global $camlStdlib__prerr_int_1239_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $prerr_int_1239)
 ))
 (global $camlStdlib__prerr_float_1251_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $prerr_float_1251)
 ))
 (global $camlStdlib__prerr_endline_1263_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $prerr_endline_1263)
 ))
 (global $camlStdlib__prerr_newline_1278_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $prerr_newline_1278)
 ))
 (global $camlStdlib__read_line_1290_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $read_line_1290)
 ))
 (global $camlStdlib__read_int_1302_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $read_int_1302)
 ))
 (global $camlStdlib__read_int_opt_1314_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $read_int_opt_1314)
 ))
 (global $camlStdlib__read_float_1327_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $read_float_1327)
 ))
 (global $camlStdlib__read_float_opt_1339_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $read_float_opt_1339)
 ))
 (global $camlStdlib__exit_1461_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $exit_1461)
 ))
 (global $camlStdlib__const_block_688 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 7)
  )
  (ref.i31
   (i32.const 0)
  )
 ))
 (global $camlStdlib__const_block_902 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 6)
  )
  (ref.i31
   (i32.const 0)
  )
 ))
 (global $camlStdlib__anon_fn_1632_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1632)
 ))
 (global $camlStdlib__anon_fn_1626_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1626)
 ))
 (global $camlStdlib__anon_fn_1619_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $anon_fn_1619)
 ))
 (global $camlStdlib__anon_fn_1613_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1613)
 ))
 (global $camlStdlib__anon_fn_1607_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1607)
 ))
 (global $camlStdlib__anon_fn_1600_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_170)
  (ref.func $anon_fn_1600)
 ))
 (global $oo_id (mut i32) (i32.const 0))
 (global $camlCamlinternalAtomic__make_26_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $make_26)
 ))
 (global $camlCamlinternalAtomic__get_33_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $get_33)
 ))
 (global $camlCamlinternalAtomic__set_40_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_153)
  (ref.func $set_40)
 ))
 (global $camlCamlinternalAtomic__exchange_48_closure (ref $Closure_2_0) (struct.new $Closure_2_0
  (i32.const 2)
  (ref.func $Caml_curry_2_153)
  (ref.func $exchange_48)
 ))
 (global $camlCamlinternalAtomic__incr_88_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $incr_88)
 ))
 (global $camlCamlinternalAtomic__decr_100_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $decr_100)
 ))
 (global $camlStdlib__const_immstring_602 (ref $String) (array.new_fixed $String 1
  (i32.const 46)
 ))
 (global $camlStdlib__anon_fn_1483_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $anon_fn_1483)
 ))
 (global $camlStdlib__Pccall_1862 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib__Pccall_1858 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib__Pccall_1857 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib__Pccall_1856 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib__Pccall_1855 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib__Pccall_1854 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib__Pccall_1853 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib__Pccall_1802 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlTaku__tak_8_closure (ref $Closure_1_0) (struct.new $Closure_1_0
  (i32.const 1)
  (ref.func $tak_8)
 ))
 (global $camlTaku__apply_arg_92 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlTaku__Pccall_144 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStd_exit__simplify_fv_27 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $global$0 (ref eq) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 248)
  )
  (array.new_fixed $String 3
   (i32.const 78)
   (i32.const 78)
   (i32.const 78)
  )
  (ref.i31
   (i32.const 0)
  )
 ))
 (global $global$1 (ref eq) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 248)
  )
  (array.new_fixed $String 3
   (i32.const 78)
   (i32.const 78)
   (i32.const 78)
  )
  (ref.i31
   (i32.const 1)
  )
 ))
 (global $global$3 (ref eq) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 248)
  )
  (array.new_fixed $String 3
   (i32.const 78)
   (i32.const 78)
   (i32.const 78)
  )
  (ref.i31
   (i32.const 4)
  )
 ))
 (global $global$4 (ref eq) (ref.i31
  (i32.const 5)
 ))
 (global $global$5 (ref eq) (ref.i31
  (i32.const 6)
 ))
 (global $global$8 (ref eq) (ref.i31
  (i32.const 9)
 ))
 (global $global$9 (ref eq) (ref.i31
  (i32.const 10)
 ))
 (global $global$10 (ref eq) (ref.i31
  (i32.const 11)
 ))
 (global $camlStdlib__Pmakeblock_1715 (ref $Array) (array.new_fixed $Array 7
  (ref.i31
   (i32.const 0)
  )
  (global.get $camlStdlib__anon_fn_1600_closure)
  (global.get $camlStdlib__anon_fn_1607_closure)
  (global.get $camlStdlib__anon_fn_1613_closure)
  (global.get $camlStdlib__anon_fn_1619_closure)
  (global.get $camlStdlib__anon_fn_1626_closure)
  (global.get $camlStdlib__anon_fn_1632_closure)
 ))
 (global $camlStdlib__const_immstring_345 (ref $String) (array.new_fixed $String 11
  (i32.const 83)
  (i32.const 116)
  (i32.const 100)
  (i32.const 108)
  (i32.const 105)
  (i32.const 98)
  (i32.const 46)
  (i32.const 69)
  (i32.const 120)
  (i32.const 105)
  (i32.const 116)
 ))
 (global $camlStdlib__Pmakeblock_1861 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 248)
  )
  (global.get $camlStdlib__const_immstring_345)
  (ref.i31
   (i32.const 123456789)
  )
 ))
 (global $camlStdlib (ref $Array) (array.new_fixed $Array 104
  (ref.i31
   (i32.const 0)
  )
  (global.get $camlStdlib__invalid_arg_334_closure)
  (global.get $camlStdlib__failwith_323_closure)
  (global.get $camlStdlib__Pmakeblock_1861)
  (global.get $global$0)
  (global.get $global$1)
  (global.get $invalid_argument)
  (global.get $global$2)
  (global.get $global$3)
  (global.get $global$4)
  (global.get $global$5)
  (global.get $global$6)
  (global.get $global$7)
  (global.get $global$8)
  (global.get $global$9)
  (global.get $global$10)
  (global.get $camlStdlib__min_378_closure)
  (global.get $camlStdlib__max_387_closure)
  (global.get $camlStdlib__abs_396_closure)
  (ref.i31
   (i32.const -1)
  )
  (ref.i31
   (i32.const 0)
  )
  (global.get $camlStdlib__lnot_407_closure)
  (ref.i31
   (i32.const 123456789)
  )
  (ref.i31
   (i32.const 123456789)
  )
  (ref.i31
   (i32.const 123456789)
  )
  (ref.i31
   (i32.const 123456789)
  )
  (ref.i31
   (i32.const 123456789)
  )
  (ref.i31
   (i32.const 123456789)
  )
  (global.get $camlStdlib__^_456_closure)
  (global.get $camlStdlib__char_of_int_481_closure)
  (global.get $camlStdlib__string_of_bool_501_closure)
  (global.get $camlStdlib__bool_of_string_opt_526_closure)
  (global.get $camlStdlib__bool_of_string_512_closure)
  (global.get $camlStdlib__string_of_int_538_closure)
  (global.get $camlStdlib__int_of_string_opt_548_closure)
  (global.get $camlStdlib__string_of_float_611_closure)
  (global.get $camlStdlib__float_of_string_opt_624_closure)
  (global.get $camlStdlib____642_closure)
  (ref.i31
   (i32.const 123456789)
  )
  (ref.i31
   (i32.const 123456789)
  )
  (ref.i31
   (i32.const 123456789)
  )
  (global.get $camlStdlib__print_char_1136_closure)
  (global.get $camlStdlib__print_string_1144_closure)
  (global.get $camlStdlib__print_bytes_1153_closure)
  (global.get $camlStdlib__print_int_1162_closure)
  (global.get $camlStdlib__print_float_1174_closure)
  (global.get $camlStdlib__print_endline_1186_closure)
  (global.get $camlStdlib__print_newline_1201_closure)
  (global.get $camlStdlib__prerr_char_1213_closure)
  (global.get $camlStdlib__prerr_string_1221_closure)
  (global.get $camlStdlib__prerr_bytes_1230_closure)
  (global.get $camlStdlib__prerr_int_1239_closure)
  (global.get $camlStdlib__prerr_float_1251_closure)
  (global.get $camlStdlib__prerr_endline_1263_closure)
  (global.get $camlStdlib__prerr_newline_1278_closure)
  (global.get $camlStdlib__read_line_1290_closure)
  (global.get $camlStdlib__read_int_opt_1314_closure)
  (global.get $camlStdlib__read_int_1302_closure)
  (global.get $camlStdlib__read_float_opt_1339_closure)
  (global.get $camlStdlib__read_float_1327_closure)
  (global.get $camlStdlib__open_out_683_closure)
  (global.get $camlStdlib__open_out_bin_699_closure)
  (global.get $camlStdlib__open_out_gen_669_closure)
  (global.get $camlStdlib__anon_fn_1491_closure)
  (global.get $camlStdlib__flush_all_715_closure)
  (global.get $camlStdlib__anon_fn_1497_closure)
  (global.get $camlStdlib__output_string_763_closure)
  (global.get $camlStdlib__output_bytes_751_closure)
  (global.get $camlStdlib__output_775_closure)
  (global.get $camlStdlib__output_substring_806_closure)
  (global.get $camlStdlib__anon_fn_1504_closure)
  (global.get $camlStdlib__anon_fn_1511_closure)
  (global.get $camlStdlib__output_value_837_closure)
  (global.get $camlStdlib__anon_fn_1518_closure)
  (global.get $camlStdlib__anon_fn_1525_closure)
  (global.get $camlStdlib__anon_fn_1531_closure)
  (global.get $camlStdlib__close_out_847_closure)
  (global.get $camlStdlib__close_out_noerr_856_closure)
  (global.get $camlStdlib__anon_fn_1537_closure)
  (global.get $camlStdlib__open_in_883_closure)
  (global.get $camlStdlib__open_in_bin_897_closure)
  (global.get $camlStdlib__open_in_gen_869_closure)
  (global.get $camlStdlib__anon_fn_1544_closure)
  (global.get $camlStdlib__input_line_1015_closure)
  (global.get $camlStdlib__input_911_closure)
  (global.get $camlStdlib__really_input_969_closure)
  (global.get $camlStdlib__really_input_string_1001_closure)
  (global.get $camlStdlib__anon_fn_1550_closure)
  (global.get $camlStdlib__anon_fn_1556_closure)
  (global.get $camlStdlib__anon_fn_1562_closure)
  (global.get $camlStdlib__anon_fn_1568_closure)
  (global.get $camlStdlib__anon_fn_1575_closure)
  (global.get $camlStdlib__anon_fn_1581_closure)
  (global.get $camlStdlib__anon_fn_1587_closure)
  (global.get $camlStdlib__close_in_noerr_1127_closure)
  (global.get $camlStdlib__anon_fn_1593_closure)
  (global.get $camlStdlib__Pmakeblock_1715)
  (global.get $camlStdlib__string_of_format_1354_closure)
  (global.get $camlStdlib__^^_1361_closure)
  (global.get $camlStdlib__exit_1461_closure)
  (global.get $camlStdlib__at_exit_1395_closure)
  (global.get $camlStdlib__valid_float_lexem_566_closure)
  (global.get $camlStdlib__unsafe_really_input_942_closure)
  (global.get $camlStdlib__do_at_exit_1448_closure)
 ))
 (global $camlStdlib__const_immstring_995 (ref $String) (array.new_fixed $String 12
  (i32.const 114)
  (i32.const 101)
  (i32.const 97)
  (i32.const 108)
  (i32.const 108)
  (i32.const 121)
  (i32.const 95)
  (i32.const 105)
  (i32.const 110)
  (i32.const 112)
  (i32.const 117)
  (i32.const 116)
 ))
 (global $camlStdlib__Pmakeblock_2451 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (global.get $invalid_argument)
  (global.get $camlStdlib__const_immstring_995)
 ))
 (global $camlStdlib__const_block_689 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 4)
  )
  (global.get $camlStdlib__const_block_688)
 ))
 (global $camlStdlib__const_block_705 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 4)
  )
  (global.get $camlStdlib__const_block_902)
 ))
 (global $camlStdlib__const_immstring_314 (ref $String) (array.new_fixed $String 19
  (i32.const 105)
  (i32.const 110)
  (i32.const 100)
  (i32.const 101)
  (i32.const 120)
  (i32.const 32)
  (i32.const 111)
  (i32.const 117)
  (i32.const 116)
  (i32.const 32)
  (i32.const 111)
  (i32.const 102)
  (i32.const 32)
  (i32.const 98)
  (i32.const 111)
  (i32.const 117)
  (i32.const 110)
  (i32.const 100)
  (i32.const 115)
 ))
 (global $camlStdlib__const_immstring_495 (ref $String) (array.new_fixed $String 11
  (i32.const 99)
  (i32.const 104)
  (i32.const 97)
  (i32.const 114)
  (i32.const 95)
  (i32.const 111)
  (i32.const 102)
  (i32.const 95)
  (i32.const 105)
  (i32.const 110)
  (i32.const 116)
 ))
 (global $camlStdlib__const_immstring_517 (ref $String) (array.new_fixed $String 14
  (i32.const 98)
  (i32.const 111)
  (i32.const 111)
  (i32.const 108)
  (i32.const 95)
  (i32.const 111)
  (i32.const 102)
  (i32.const 95)
  (i32.const 115)
  (i32.const 116)
  (i32.const 114)
  (i32.const 105)
  (i32.const 110)
  (i32.const 103)
 ))
 (global $camlStdlib__const_block_690 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 3)
  )
  (global.get $camlStdlib__const_block_689)
 ))
 (global $camlStdlib__const_block_706 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 3)
  )
  (global.get $camlStdlib__const_block_705)
 ))
 (global $camlStdlib__const_immstring_800 (ref $String) (array.new_fixed $String 6
  (i32.const 111)
  (i32.const 117)
  (i32.const 116)
  (i32.const 112)
  (i32.const 117)
  (i32.const 116)
 ))
 (global $camlStdlib__const_immstring_831 (ref $String) (array.new_fixed $String 16
  (i32.const 111)
  (i32.const 117)
  (i32.const 116)
  (i32.const 112)
  (i32.const 117)
  (i32.const 116)
  (i32.const 95)
  (i32.const 115)
  (i32.const 117)
  (i32.const 98)
  (i32.const 115)
  (i32.const 116)
  (i32.const 114)
  (i32.const 105)
  (i32.const 110)
  (i32.const 103)
 ))
 (global $camlStdlib__const_immstring_936 (ref $String) (array.new_fixed $String 5
  (i32.const 105)
  (i32.const 110)
  (i32.const 112)
  (i32.const 117)
  (i32.const 116)
 ))
 (global $empty_list (ref eq) (ref.i31
  (i32.const 0)
 ))
 (global $os_type (ref $String) (array.new_fixed $String 4
  (i32.const 87)
  (i32.const 97)
  (i32.const 115)
  (i32.const 109)
 ))
 (global $executable_name (ref $String) (array.new_fixed $String 15
  (i32.const 119)
  (i32.const 97)
  (i32.const 115)
  (i32.const 111)
  (i32.const 99)
  (i32.const 97)
  (i32.const 109)
  (i32.const 108)
  (i32.const 95)
  (i32.const 98)
  (i32.const 105)
  (i32.const 110)
  (i32.const 97)
  (i32.const 114)
  (i32.const 121)
 ))
 (global $camlStdlib__const_immstring_311 (ref $String) (array.new_fixed $String 28
  (i32.const 80)
  (i32.const 101)
  (i32.const 114)
  (i32.const 118)
  (i32.const 97)
  (i32.const 115)
  (i32.const 105)
  (i32.const 118)
  (i32.const 101)
  (i32.const 115)
  (i32.const 46)
  (i32.const 97)
  (i32.const 114)
  (i32.const 114)
  (i32.const 97)
  (i32.const 121)
  (i32.const 95)
  (i32.const 98)
  (i32.const 111)
  (i32.const 117)
  (i32.const 110)
  (i32.const 100)
  (i32.const 95)
  (i32.const 101)
  (i32.const 114)
  (i32.const 114)
  (i32.const 111)
  (i32.const 114)
 ))
 (global $camlStdlib__const_immstring_506 (ref $String) (array.new_fixed $String 5
  (i32.const 102)
  (i32.const 97)
  (i32.const 108)
  (i32.const 115)
  (i32.const 101)
 ))
 (global $camlStdlib__const_immstring_508 (ref $String) (array.new_fixed $String 4
  (i32.const 116)
  (i32.const 114)
  (i32.const 117)
  (i32.const 101)
 ))
 (global $camlStdlib__const_block_532 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 0)
  )
 ))
 (global $camlStdlib__const_block_534 (ref $Array) (array.new_fixed $Array 2
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 1)
  )
 ))
 (global $camlStdlib__const_block_691 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 1)
  )
  (global.get $camlStdlib__const_block_690)
 ))
 (global $camlStdlib__const_block_707 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 1)
  )
  (global.get $camlStdlib__const_block_706)
 ))
 (global $camlStdlib__const_block_889 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 0)
  )
  (global.get $camlStdlib__const_block_688)
 ))
 (global $camlStdlib__const_block_903 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (ref.i31
   (i32.const 0)
  )
  (global.get $camlStdlib__const_block_902)
 ))
 (global $camlStdlib__const_immstring_1376 (ref $String) (array.new_fixed $String 2
  (i32.const 37)
  (i32.const 44)
 ))
 (global $camlStdlib__const_immstring_1473 (ref $String) (array.new_fixed $String 21
  (i32.const 80)
  (i32.const 101)
  (i32.const 114)
  (i32.const 118)
  (i32.const 97)
  (i32.const 115)
  (i32.const 105)
  (i32.const 118)
  (i32.const 101)
  (i32.const 115)
  (i32.const 46)
  (i32.const 100)
  (i32.const 111)
  (i32.const 95)
  (i32.const 97)
  (i32.const 116)
  (i32.const 95)
  (i32.const 101)
  (i32.const 120)
  (i32.const 105)
  (i32.const 116)
 ))
 (global $camlStdlib__Pmakeblock_1665 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (global.get $invalid_argument)
  (global.get $camlStdlib__const_immstring_314)
 ))
 (global $camlStdlib__Pmakeblock_2452 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (global.get $invalid_argument)
  (global.get $camlStdlib__const_immstring_495)
 ))
 (global $camlStdlib__Pmakeblock_2453 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (global.get $invalid_argument)
  (global.get $camlStdlib__const_immstring_517)
 ))
 (global $camlStdlib__Pmakeblock_2443 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (global.get $invalid_argument)
  (global.get $camlStdlib__const_immstring_800)
 ))
 (global $camlStdlib__Pmakeblock_2454 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (global.get $invalid_argument)
  (global.get $camlStdlib__const_immstring_831)
 ))
 (global $camlStdlib__Pmakeblock_2450 (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (global.get $invalid_argument)
  (global.get $camlStdlib__const_immstring_936)
 ))
 (global $camlStdlib__Pccall_arg_2827 (ref $Int64) (struct.new $Int64
  (i64.const 4372995238176751616)
 ))
 (global $camlStdlib__Pccall_arg_2826 (ref $Int64) (struct.new $Int64
  (i64.const 4503599627370496)
 ))
 (global $camlStdlib__Pccall_arg_2825 (ref $Int64) (struct.new $Int64
  (i64.const 9218868437227405311)
 ))
 (global $camlStdlib__Pccall_arg_2824 (ref $Int64) (struct.new $Int64
  (i64.const 9218868437227405313)
 ))
 (global $camlStdlib__Pccall_arg_2823 (ref $Int64) (struct.new $Int64
  (i64.const -4503599627370496)
 ))
 (global $camlStdlib__Pccall_arg_2822 (ref $Int64) (struct.new $Int64
  (i64.const 9218868437227405312)
 ))
 (global $camlCamlinternalFormatBasics__set_of_closures_382 (ref eq) (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure))
 (global $camlCamlinternalFormatBasics__set_of_closures_383 (ref eq) (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure))
 (global $camlCamlinternalFormatBasics__set_of_closures_384 (ref eq) (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure))
 (global $camlCamlinternalFormatBasics (ref $Array) (array.new_fixed $Array 4
  (ref.i31
   (i32.const 0)
  )
  (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
  (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
  (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
 ))
 (global $camlCamlinternalAtomic__make_113 (ref eq) (global.get $camlCamlinternalAtomic__make_26_closure))
 (global $camlCamlinternalAtomic__get_114 (ref eq) (global.get $camlCamlinternalAtomic__get_33_closure))
 (global $camlCamlinternalAtomic__set_115 (ref eq) (global.get $camlCamlinternalAtomic__set_40_closure))
 (global $camlCamlinternalAtomic__exchange_116 (ref eq) (global.get $camlCamlinternalAtomic__exchange_48_closure))
 (global $camlCamlinternalAtomic__compare_and_set_117 (ref eq) (global.get $camlCamlinternalAtomic__compare_and_set_59_closure))
 (global $camlCamlinternalAtomic__fetch_and_add_118 (ref eq) (global.get $camlCamlinternalAtomic__fetch_and_add_75_closure))
 (global $camlCamlinternalAtomic__incr_119 (ref eq) (global.get $camlCamlinternalAtomic__incr_88_closure))
 (global $camlCamlinternalAtomic__decr_120 (ref eq) (global.get $camlCamlinternalAtomic__decr_100_closure))
 (global $camlCamlinternalAtomic (ref $Array) (array.new_fixed $Array 9
  (ref.i31
   (i32.const 0)
  )
  (global.get $camlCamlinternalAtomic__make_26_closure)
  (global.get $camlCamlinternalAtomic__get_33_closure)
  (global.get $camlCamlinternalAtomic__set_40_closure)
  (global.get $camlCamlinternalAtomic__exchange_48_closure)
  (global.get $camlCamlinternalAtomic__compare_and_set_59_closure)
  (global.get $camlCamlinternalAtomic__fetch_and_add_75_closure)
  (global.get $camlCamlinternalAtomic__incr_88_closure)
  (global.get $camlCamlinternalAtomic__decr_100_closure)
 ))
 (global $camlStdlib__failwith_1666 (ref eq) (global.get $camlStdlib__failwith_323_closure))
 (global $camlStdlib__invalid_arg_1667 (ref eq) (global.get $camlStdlib__invalid_arg_334_closure))
 (global $camlStdlib__min_1668 (ref eq) (global.get $camlStdlib__min_378_closure))
 (global $camlStdlib__max_1669 (ref eq) (global.get $camlStdlib__max_387_closure))
 (global $camlStdlib__abs_1670 (ref eq) (global.get $camlStdlib__abs_396_closure))
 (global $camlStdlib__lnot_1671 (ref eq) (global.get $camlStdlib__lnot_407_closure))
 (global $camlStdlib__^_1672 (ref eq) (global.get $camlStdlib__^_456_closure))
 (global $camlStdlib__char_of_int_1673 (ref eq) (global.get $camlStdlib__char_of_int_481_closure))
 (global $camlStdlib__string_of_bool_1674 (ref eq) (global.get $camlStdlib__string_of_bool_501_closure))
 (global $camlStdlib__bool_of_string_1675 (ref eq) (global.get $camlStdlib__bool_of_string_512_closure))
 (global $camlStdlib__bool_of_string_opt_1676 (ref eq) (global.get $camlStdlib__bool_of_string_opt_526_closure))
 (global $camlStdlib__string_of_int_1677 (ref eq) (global.get $camlStdlib__string_of_int_538_closure))
 (global $camlStdlib__int_of_string_opt_1678 (ref eq) (global.get $camlStdlib__int_of_string_opt_548_closure))
 (global $camlStdlib__valid_float_lexem_1679 (ref eq) (global.get $camlStdlib__valid_float_lexem_566_closure))
 (global $camlStdlib__string_of_float_1680 (ref eq) (global.get $camlStdlib__string_of_float_611_closure))
 (global $camlStdlib__float_of_string_opt_1681 (ref eq) (global.get $camlStdlib__float_of_string_opt_624_closure))
 (global $camlStdlib__set_of_closures_1682 (ref eq) (global.get $camlStdlib____642_closure))
 (global $camlStdlib__open_out_gen_1683 (ref eq) (global.get $camlStdlib__open_out_gen_669_closure))
 (global $camlStdlib__open_out_1684 (ref eq) (global.get $camlStdlib__open_out_683_closure))
 (global $camlStdlib__open_out_bin_1685 (ref eq) (global.get $camlStdlib__open_out_bin_699_closure))
 (global $camlStdlib__set_of_closures_1687 (ref eq) (global.get $camlStdlib__iter_721_closure))
 (global $camlStdlib__flush_all_1686 (ref eq) (global.get $camlStdlib__flush_all_715_closure))
 (global $camlStdlib__output_bytes_1688 (ref eq) (global.get $camlStdlib__output_bytes_751_closure))
 (global $camlStdlib__output_string_1689 (ref eq) (global.get $camlStdlib__output_string_763_closure))
 (global $camlStdlib__output_1690 (ref eq) (global.get $camlStdlib__output_775_closure))
 (global $camlStdlib__output_substring_1691 (ref eq) (global.get $camlStdlib__output_substring_806_closure))
 (global $camlStdlib__output_value_1692 (ref eq) (global.get $camlStdlib__output_value_837_closure))
 (global $camlStdlib__close_out_1693 (ref eq) (global.get $camlStdlib__close_out_847_closure))
 (global $camlStdlib__close_out_noerr_1694 (ref eq) (global.get $camlStdlib__close_out_noerr_856_closure))
 (global $camlStdlib__open_in_gen_1695 (ref eq) (global.get $camlStdlib__open_in_gen_869_closure))
 (global $camlStdlib__open_in_1696 (ref eq) (global.get $camlStdlib__open_in_883_closure))
 (global $camlStdlib__open_in_bin_1697 (ref eq) (global.get $camlStdlib__open_in_bin_897_closure))
 (global $camlStdlib__input_1698 (ref eq) (global.get $camlStdlib__input_911_closure))
 (global $camlStdlib__set_of_closures_1699 (ref eq) (global.get $camlStdlib__unsafe_really_input_942_closure))
 (global $camlStdlib__really_input_1700 (ref eq) (global.get $camlStdlib__really_input_969_closure))
 (global $camlStdlib__really_input_string_1701 (ref eq) (global.get $camlStdlib__really_input_string_1001_closure))
 (global $camlStdlib__set_of_closures_1703 (ref eq) (global.get $camlStdlib__build_result_1021_closure))
 (global $camlStdlib__input_line_1702 (ref eq) (global.get $camlStdlib__input_line_1015_closure))
 (global $camlStdlib__close_in_noerr_1704 (ref eq) (global.get $camlStdlib__close_in_noerr_1127_closure))
 (global $camlStdlib__string_of_format_1706 (ref eq) (global.get $camlStdlib__string_of_format_1354_closure))
 (global $camlStdlib__^^_1707 (ref eq) (global.get $camlStdlib__^^_1361_closure))
 (global $camlStdlib__set_of_closures_1708 (ref eq) (global.get $camlStdlib__anon_fn_1483_closure))
 (global $camlStdlib__set_of_closures_1709 (ref eq) (global.get $camlStdlib__anon_fn_1632_closure))
 (global $camlStdlib__set_of_closures_1710 (ref eq) (global.get $camlStdlib__anon_fn_1626_closure))
 (global $camlStdlib__set_of_closures_1711 (ref eq) (global.get $camlStdlib__anon_fn_1619_closure))
 (global $camlStdlib__set_of_closures_1712 (ref eq) (global.get $camlStdlib__anon_fn_1613_closure))
 (global $camlStdlib__set_of_closures_1713 (ref eq) (global.get $camlStdlib__anon_fn_1607_closure))
 (global $camlStdlib__set_of_closures_1714 (ref eq) (global.get $camlStdlib__anon_fn_1600_closure))
 (global $camlStdlib__set_of_closures_1716 (ref eq) (global.get $camlStdlib__anon_fn_1593_closure))
 (global $camlStdlib__set_of_closures_1717 (ref eq) (global.get $camlStdlib__anon_fn_1587_closure))
 (global $camlStdlib__set_of_closures_1718 (ref eq) (global.get $camlStdlib__anon_fn_1581_closure))
 (global $camlStdlib__set_of_closures_1719 (ref eq) (global.get $camlStdlib__anon_fn_1575_closure))
 (global $camlStdlib__set_of_closures_1720 (ref eq) (global.get $camlStdlib__anon_fn_1568_closure))
 (global $camlStdlib__set_of_closures_1721 (ref eq) (global.get $camlStdlib__anon_fn_1562_closure))
 (global $camlStdlib__set_of_closures_1722 (ref eq) (global.get $camlStdlib__anon_fn_1556_closure))
 (global $camlStdlib__set_of_closures_1723 (ref eq) (global.get $camlStdlib__anon_fn_1550_closure))
 (global $camlStdlib__set_of_closures_1724 (ref eq) (global.get $camlStdlib__anon_fn_1544_closure))
 (global $camlStdlib__set_of_closures_1725 (ref eq) (global.get $camlStdlib__anon_fn_1537_closure))
 (global $camlStdlib__set_of_closures_1726 (ref eq) (global.get $camlStdlib__anon_fn_1531_closure))
 (global $camlStdlib__set_of_closures_1727 (ref eq) (global.get $camlStdlib__anon_fn_1525_closure))
 (global $camlStdlib__set_of_closures_1728 (ref eq) (global.get $camlStdlib__anon_fn_1518_closure))
 (global $camlStdlib__set_of_closures_1729 (ref eq) (global.get $camlStdlib__anon_fn_1511_closure))
 (global $camlStdlib__set_of_closures_1730 (ref eq) (global.get $camlStdlib__anon_fn_1504_closure))
 (global $camlStdlib__set_of_closures_1731 (ref eq) (global.get $camlStdlib__anon_fn_1497_closure))
 (global $camlStdlib__set_of_closures_1732 (ref eq) (global.get $camlStdlib__anon_fn_1491_closure))
 (global $camlStdlib__do_at_exit_2236 (ref eq) (global.get $camlStdlib__do_at_exit_1448_closure))
 (global $camlStdlib__print_char_2216 (ref eq) (global.get $camlStdlib__print_char_1136_closure))
 (global $camlStdlib__print_string_2217 (ref eq) (global.get $camlStdlib__print_string_1144_closure))
 (global $camlStdlib__print_bytes_2218 (ref eq) (global.get $camlStdlib__print_bytes_1153_closure))
 (global $camlStdlib__print_int_2219 (ref eq) (global.get $camlStdlib__print_int_1162_closure))
 (global $camlStdlib__print_float_2220 (ref eq) (global.get $camlStdlib__print_float_1174_closure))
 (global $camlStdlib__print_endline_2221 (ref eq) (global.get $camlStdlib__print_endline_1186_closure))
 (global $camlStdlib__print_newline_2222 (ref eq) (global.get $camlStdlib__print_newline_1201_closure))
 (global $camlStdlib__prerr_char_2223 (ref eq) (global.get $camlStdlib__prerr_char_1213_closure))
 (global $camlStdlib__prerr_string_2224 (ref eq) (global.get $camlStdlib__prerr_string_1221_closure))
 (global $camlStdlib__prerr_bytes_2225 (ref eq) (global.get $camlStdlib__prerr_bytes_1230_closure))
 (global $camlStdlib__prerr_int_2226 (ref eq) (global.get $camlStdlib__prerr_int_1239_closure))
 (global $camlStdlib__prerr_float_2227 (ref eq) (global.get $camlStdlib__prerr_float_1251_closure))
 (global $camlStdlib__prerr_endline_2228 (ref eq) (global.get $camlStdlib__prerr_endline_1263_closure))
 (global $camlStdlib__prerr_newline_2229 (ref eq) (global.get $camlStdlib__prerr_newline_1278_closure))
 (global $camlStdlib__read_line_2230 (ref eq) (global.get $camlStdlib__read_line_1290_closure))
 (global $camlStdlib__read_int_2231 (ref eq) (global.get $camlStdlib__read_int_1302_closure))
 (global $camlStdlib__read_int_opt_2232 (ref eq) (global.get $camlStdlib__read_int_opt_1314_closure))
 (global $camlStdlib__read_float_2233 (ref eq) (global.get $camlStdlib__read_float_1327_closure))
 (global $camlStdlib__read_float_opt_2234 (ref eq) (global.get $camlStdlib__read_float_opt_1339_closure))
 (global $camlStdlib__set_of_closures_2235 (ref eq) (global.get $camlStdlib__at_exit_1395_closure))
 (global $camlStdlib__exit_2237 (ref eq) (global.get $camlStdlib__exit_1461_closure))
 (global $camlTaku__set_of_closures_84 (ref $Set_of_closures_Taku.51) (struct.new $Set_of_closures_Taku.51
  (global.get $camlTaku__tak_8_closure)
  (global.get $camlTaku__tak_43_closure)
 ))
 (global $camlTaku__set_of_closures_85 (ref eq) (global.get $camlTaku__repeat_49_closure))
 (global $camlTaku (ref $Array) (array.new_fixed $Array 3
  (ref.i31
   (i32.const 0)
  )
  (global.get $camlTaku__tak_8_closure)
  (global.get $camlTaku__repeat_49_closure)
 ))
 (global $camlStd_exit (ref $Array) (array.new_fixed $Array 1
  (ref.i31
   (i32.const 0)
  )
 ))
 (elem declare func $Caml_curry_2_1 $Caml_curry_2_170 $Caml_curry_2_1_153 $Caml_curry_2_1_170 $Caml_curry_2_1_321 $Caml_curry_3_1 $Caml_curry_3_1_170 $Caml_curry_3_1_321 $Caml_curry_3_2 $Caml_curry_3_2_170 $Caml_curry_3_2_321 $Caml_curry_4_1 $Caml_curry_4_2 $Caml_curry_4_3 $loop_574 $new_exit_1413 $new_exit_2705 $scan_1045)
 (export "caml_exn_Match_failure" (global $global$0))
 (export "caml_exn_Assert_failure" (global $global$1))
 (export "caml_exn_Invalid_argument" (global $invalid_argument))
 (export "caml_exn_Failure" (global $global$2))
 (export "caml_exn_Not_found" (global $global$3))
 (export "caml_exn_Out_of_memory" (global $global$4))
 (export "caml_exn_Stack_overflow" (global $global$5))
 (export "caml_exn_Sys_error" (global $global$6))
 (export "caml_exn_End_of_file" (global $global$7))
 (export "caml_exn_Division_by_zero" (global $global$8))
 (export "caml_exn_Sys_blocked_io" (global $global$9))
 (export "caml_exn_Undefined_recursive_module" (global $global$10))
 (export "compare_ints" (func $0))
 (export "compare_floats" (func $1))
 (export "array_length" (func $array_length))
 (export "array_get_float_safe" (func $2))
 (export "array_get_int_or_addr_safe" (func $3))
 (export "array_set_int_or_addr_unsafe" (func $array_set_int_or_addr_unsafe))
 (export "array_set_unsafe" (func $array_set_unsafe))
 (export "array_set_safe" (func $4))
 (export "duparray" (func $5))
 (export "bytes_set" (func $6))
 (export "string_get" (func $7))
 (export "string_eq" (func $8))
 (export "string_neq" (func $9))
 (export "unimplemented_1" (func $10))
 (export "unimplemented_2" (func $11))
 (export "unimplemented_3" (func $12))
 (export "array_get_safe" (func $array_get_safe))
 (export "array_get_unsafe" (func $array_get_safe))
 (export "array_set_int_or_addr_safe" (func $array_set_int_or_addr_unsafe))
 (export "array_set_float_safe" (func $array_set_float_unsafe))
 (export "print_string" (func $print_string_23))
 (export "caml_int64_float_of_bits" (func $0_23))
 (export "caml_int64_float_of_bits_unboxed" (func $1_23))
 (export "caml_obj_tag" (func $C_caml_obj_tag))
 (export "caml_obj_make_forward" (func $C_caml_obj_make_forward))
 (export "caml_lazy_make_forward" (func $C_caml_lazy_make_forward))
 (export "caml_obj_block" (func $C_caml_obj_block))
 (export "caml_fresh_oo_id" (func $2_23))
 (export "atan2" (func $C_atan2))
 (export "sqrt" (func $C_sqrt))
 (export "sin" (func $C_sin))
 (export "cos" (func $C_cos))
 (export "asin" (func $C_asin))
 (export "fmod" (func $C_fmod))
 (export "caml_create_bytes" (func $3_23))
 (export "caml_fill_bytes" (func $4_23))
 (export "caml_blit_string" (func $5_23))
 (export "caml_blit_bytes" (func $6_23))
 (export "caml_classify_float_unboxed" (func $7_23))
 (export "caml_compare" (func $compare))
 (export "compare_data_non_block" (func $caml_compare_data_non_block))
 (export "caml_equal" (func $caml_equal))
 (export "equal_data_non_block" (func $equal_data_non_block))
 (export "caml_notequal" (func $8_23))
 (export "caml_lessequal" (func $9_23))
 (export "caml_greaterequal" (func $10_23))
 (export "caml_greaterthan" (func $C_caml_greaterthan))
 (export "caml_lessthan" (func $C_caml_lessthan))
 (export "caml_format_int" (func $11_23))
 (export "caml_format_float" (func $12_23))
 (export "caml_int_of_string" (func $13))
 (export "caml_float_of_string" (func $14))
 (export "caml_ml_open_descriptor_out" (func $15))
 (export "caml_ml_open_descriptor_in" (func $16))
 (export "caml_sys_open" (func $17))
 (export "caml_ml_flush" (func $18))
 (export "caml_ml_out_channels_list" (func $19))
 (export "caml_ml_output" (func $caml_ml_output))
 (export "caml_ml_output_bytes" (func $20))
 (export "caml_ml_output_int" (func $21))
 (export "caml_ml_output_char" (func $22))
 (export "caml_ml_output_string" (func $23))
 (export "caml_output_value" (func $24))
 (export "caml_ml_seek_out" (func $25))
 (export "caml_ml_seek_out_64" (func $26))
 (export "caml_ml_input_scan_line" (func $27))
 (export "caml_ml_input" (func $28))
 (export "caml_ml_input_char" (func $29))
 (export "caml_ml_input_int" (func $30))
 (export "caml_input_value" (func $31))
 (export "caml_ml_seek_in" (func $32))
 (export "caml_ml_seek_in_64" (func $33))
 (export "caml_ml_pos_in" (func $34))
 (export "caml_ml_pos_in_64" (func $35))
 (export "caml_ml_channel_size" (func $36))
 (export "caml_ml_channel_size_64" (func $37))
 (export "caml_ml_close_channel" (func $38))
 (export "caml_ml_pos_out" (func $39))
 (export "caml_ml_pos_out_64" (func $40))
 (export "caml_ml_set_binary_mode" (func $41))
 (export "caml_ml_set_channel_name" (func $42))
 (export "caml_sys_exit" (func $43))
 (export "caml_register_named_value" (func $44))
 (export "caml_sys_getenv" (func $C_caml_sys_getenv))
 (export "caml_sys_get_config" (func $C_caml_sys_get_config))
 (export "caml_sys_executable_name" (func $C_caml_sys_executable_name))
 (export "caml_ml_runtime_warnings_enabled" (func $C_caml_ml_runtime_warnings_enabled))
 (export "caml_ml_enable_runtime_warnings" (func $C_caml_ml_enable_runtime_warnings))
 (export "caml_install_signal_handler" (func $C_caml_install_signal_handler))
 (export "caml_obj_raw_field" (func $C_caml_obj_raw_field))
 (export "caml_floatarray_set" (func $C_caml_floatarray_set))
 (export "caml_floatarray_get" (func $C_caml_floatarray_get))
 (export "caml_ephe_unset_key" (func $C_caml_ephe_unset_key))
 (export "caml_ephe_unset_data" (func $C_caml_ephe_unset_data))
 (export "caml_ephe_set_key" (func $C_caml_ephe_set_key))
 (export "caml_ephe_set_data" (func $C_caml_ephe_set_data))
 (export "caml_ephe_get_key_copy" (func $C_caml_ephe_get_key_copy))
 (export "caml_ephe_get_key" (func $C_caml_ephe_get_key))
 (export "caml_ephe_get_data_copy" (func $C_caml_ephe_get_data_copy))
 (export "caml_ephe_get_data" (func $C_caml_ephe_get_data))
 (export "caml_ephe_create" (func $C_caml_ephe_create))
 (export "caml_ephe_check_key" (func $C_caml_ephe_check_key))
 (export "caml_ephe_check_data" (func $C_caml_ephe_check_data))
 (export "caml_ephe_blit_key" (func $C_caml_ephe_blit_key))
 (export "caml_ephe_blit_data" (func $C_caml_ephe_blit_data))
 (export "caml_gc_major" (func $45))
 (export "caml_gc_minor" (func $46))
 (export "caml_sys_const_naked_pointers_checked" (func $47))
 (export "caml_int32_format" (func $48))
 (export "caml_nativeint_format" (func $49))
 (export "caml_int64_format" (func $50))
 (export "caml_hexstring_of_float" (func $51))
 (export "caml_make_vect" (func $52))
 (export "caml_make_float_vect" (func $53))
 (export "caml_array_sub" (func $54))
 (export "caml_array_append" (func $55))
 (export "caml_array_concat" (func $56))
 (export "caml_array_blit" (func $57))
 (export "caml_array_fill" (func $58))
 (export "print_int" (func $59))
 (export "print_float" (func $60))
 (export "print_endline" (func $61))
 (export "caml_bytes_equal" (func $8))
 (export "caml_string_equal" (func $8))
 (export "caml_string_notequal" (func $8))
 (export "caml_bytes_compare" (func $caml_string_compare))
 (export "caml_string_compare" (func $caml_string_compare))
 (export "Caml_curry_2_1" (func $Caml_curry_2_1))
 (export "Caml_curry_2" (func $Caml_curry_2))
 (export "camlCamlinternalFormatBasics__erase_rel_11_closure" (global $camlCamlinternalFormatBasics__erase_rel_11_closure))
 (export "camlCamlinternalFormatBasics__set_of_closures_382" (global $camlCamlinternalFormatBasics__set_of_closures_382))
 (export "camlCamlinternalFormatBasics__concat_fmtty_97_closure" (global $camlCamlinternalFormatBasics__concat_fmtty_97_closure))
 (export "camlCamlinternalFormatBasics__set_of_closures_383" (global $camlCamlinternalFormatBasics__set_of_closures_383))
 (export "camlCamlinternalFormatBasics__concat_fmt_185_closure" (global $camlCamlinternalFormatBasics__concat_fmt_185_closure))
 (export "camlCamlinternalFormatBasics__set_of_closures_384" (global $camlCamlinternalFormatBasics__set_of_closures_384))
 (export "camlCamlinternalFormatBasics" (global $camlCamlinternalFormatBasics))
 (export "R_not_really_start" (func $R_not_really_start))
 (export "Start" (func $Start))
 (export "erase_rel_11" (func $erase_rel_11))
 (export "concat_fmtty_97" (func $concat_fmtty_97))
 (export "concat_fmt_185" (func $concat_fmt_185))
 (export "Caml_curry_3_2" (func $Caml_curry_3_2))
 (export "Caml_curry_3_1" (func $Caml_curry_3_1))
 (export "Caml_curry_3" (func $Caml_curry_3))
 (export "camlCamlinternalAtomic__make_26_closure" (global $camlCamlinternalAtomic__make_26_closure))
 (export "camlCamlinternalAtomic__make_113" (global $camlCamlinternalAtomic__make_113))
 (export "camlCamlinternalAtomic__get_33_closure" (global $camlCamlinternalAtomic__get_33_closure))
 (export "camlCamlinternalAtomic__get_114" (global $camlCamlinternalAtomic__get_114))
 (export "camlCamlinternalAtomic__set_40_closure" (global $camlCamlinternalAtomic__set_40_closure))
 (export "camlCamlinternalAtomic__set_115" (global $camlCamlinternalAtomic__set_115))
 (export "camlCamlinternalAtomic__exchange_48_closure" (global $camlCamlinternalAtomic__exchange_48_closure))
 (export "camlCamlinternalAtomic__exchange_116" (global $camlCamlinternalAtomic__exchange_116))
 (export "camlCamlinternalAtomic__compare_and_set_59_closure" (global $camlCamlinternalAtomic__compare_and_set_59_closure))
 (export "camlCamlinternalAtomic__compare_and_set_117" (global $camlCamlinternalAtomic__compare_and_set_117))
 (export "camlCamlinternalAtomic__fetch_and_add_75_closure" (global $camlCamlinternalAtomic__fetch_and_add_75_closure))
 (export "camlCamlinternalAtomic__fetch_and_add_118" (global $camlCamlinternalAtomic__fetch_and_add_118))
 (export "camlCamlinternalAtomic__incr_88_closure" (global $camlCamlinternalAtomic__incr_88_closure))
 (export "camlCamlinternalAtomic__incr_119" (global $camlCamlinternalAtomic__incr_119))
 (export "camlCamlinternalAtomic__decr_100_closure" (global $camlCamlinternalAtomic__decr_100_closure))
 (export "camlCamlinternalAtomic__decr_120" (global $camlCamlinternalAtomic__decr_120))
 (export "camlCamlinternalAtomic" (global $camlCamlinternalAtomic))
 (export "make_26" (func $make_26))
 (export "get_33" (func $get_33))
 (export "set_40" (func $set_40))
 (export "exchange_48" (func $exchange_48))
 (export "compare_and_set_59" (func $compare_and_set_59))
 (export "fetch_and_add_75" (func $fetch_and_add_75))
 (export "incr_88" (func $incr_88))
 (export "decr_100" (func $decr_100))
 (export "Caml_curry_4_3" (func $Caml_curry_4_3))
 (export "Caml_curry_4_2" (func $Caml_curry_4_2))
 (export "Caml_curry_4_1" (func $Caml_curry_4_1))
 (export "Caml_curry_4" (func $Caml_curry_4))
 (export "camlStdlib__const_immstring_311" (global $camlStdlib__const_immstring_311))
 (export "camlStdlib__const_immstring_314" (global $camlStdlib__const_immstring_314))
 (export "camlStdlib__const_immstring_345" (global $camlStdlib__const_immstring_345))
 (export "camlStdlib__const_immstring_495" (global $camlStdlib__const_immstring_495))
 (export "camlStdlib__const_immstring_506" (global $camlStdlib__const_immstring_506))
 (export "camlStdlib__const_immstring_508" (global $camlStdlib__const_immstring_508))
 (export "camlStdlib__const_immstring_517" (global $camlStdlib__const_immstring_517))
 (export "camlStdlib__const_block_532" (global $camlStdlib__const_block_532))
 (export "camlStdlib__const_block_534" (global $camlStdlib__const_block_534))
 (export "camlStdlib__const_immstring_542" (global $camlStdlib__const_immstring_542))
 (export "camlStdlib__const_immstring_602" (global $camlStdlib__const_immstring_602))
 (export "camlStdlib__const_immstring_616" (global $camlStdlib__const_immstring_616))
 (export "camlStdlib__const_block_688" (global $camlStdlib__const_block_688))
 (export "camlStdlib__const_block_689" (global $camlStdlib__const_block_689))
 (export "camlStdlib__const_block_690" (global $camlStdlib__const_block_690))
 (export "camlStdlib__const_block_691" (global $camlStdlib__const_block_691))
 (export "camlStdlib__const_block_902" (global $camlStdlib__const_block_902))
 (export "camlStdlib__const_block_705" (global $camlStdlib__const_block_705))
 (export "camlStdlib__const_block_706" (global $camlStdlib__const_block_706))
 (export "camlStdlib__const_block_707" (global $camlStdlib__const_block_707))
 (export "camlStdlib__const_immstring_800" (global $camlStdlib__const_immstring_800))
 (export "camlStdlib__const_immstring_831" (global $camlStdlib__const_immstring_831))
 (export "camlStdlib__const_block_889" (global $camlStdlib__const_block_889))
 (export "camlStdlib__const_block_903" (global $camlStdlib__const_block_903))
 (export "camlStdlib__const_immstring_936" (global $camlStdlib__const_immstring_936))
 (export "camlStdlib__const_immstring_995" (global $camlStdlib__const_immstring_995))
 (export "camlStdlib__const_immstring_1376" (global $camlStdlib__const_immstring_1376))
 (export "camlStdlib__const_immstring_1473" (global $camlStdlib__const_immstring_1473))
 (export "camlStdlib__Pmakeblock_1665" (global $camlStdlib__Pmakeblock_1665))
 (export "camlStdlib__failwith_323_closure" (global $camlStdlib__failwith_323_closure))
 (export "camlStdlib__failwith_1666" (global $camlStdlib__failwith_1666))
 (export "camlStdlib__invalid_arg_334_closure" (global $camlStdlib__invalid_arg_334_closure))
 (export "camlStdlib__invalid_arg_1667" (global $camlStdlib__invalid_arg_1667))
 (export "camlStdlib__min_378_closure" (global $camlStdlib__min_378_closure))
 (export "camlStdlib__min_1668" (global $camlStdlib__min_1668))
 (export "camlStdlib__max_387_closure" (global $camlStdlib__max_387_closure))
 (export "camlStdlib__max_1669" (global $camlStdlib__max_1669))
 (export "camlStdlib__abs_396_closure" (global $camlStdlib__abs_396_closure))
 (export "camlStdlib__abs_1670" (global $camlStdlib__abs_1670))
 (export "camlStdlib__lnot_407_closure" (global $camlStdlib__lnot_407_closure))
 (export "camlStdlib__lnot_1671" (global $camlStdlib__lnot_1671))
 (export "camlStdlib__^_456_closure" (global $camlStdlib__^_456_closure))
 (export "camlStdlib__^_1672" (global $camlStdlib__^_1672))
 (export "camlStdlib__Pmakeblock_2452" (global $camlStdlib__Pmakeblock_2452))
 (export "camlStdlib__char_of_int_481_closure" (global $camlStdlib__char_of_int_481_closure))
 (export "camlStdlib__char_of_int_1673" (global $camlStdlib__char_of_int_1673))
 (export "camlStdlib__string_of_bool_501_closure" (global $camlStdlib__string_of_bool_501_closure))
 (export "camlStdlib__string_of_bool_1674" (global $camlStdlib__string_of_bool_1674))
 (export "camlStdlib__Pmakeblock_2453" (global $camlStdlib__Pmakeblock_2453))
 (export "camlStdlib__bool_of_string_512_closure" (global $camlStdlib__bool_of_string_512_closure))
 (export "camlStdlib__bool_of_string_1675" (global $camlStdlib__bool_of_string_1675))
 (export "camlStdlib__bool_of_string_opt_526_closure" (global $camlStdlib__bool_of_string_opt_526_closure))
 (export "camlStdlib__bool_of_string_opt_1676" (global $camlStdlib__bool_of_string_opt_1676))
 (export "camlStdlib__string_of_int_538_closure" (global $camlStdlib__string_of_int_538_closure))
 (export "camlStdlib__string_of_int_1677" (global $camlStdlib__string_of_int_1677))
 (export "camlStdlib__int_of_string_opt_548_closure" (global $camlStdlib__int_of_string_opt_548_closure))
 (export "camlStdlib__int_of_string_opt_1678" (global $camlStdlib__int_of_string_opt_1678))
 (export "camlStdlib__valid_float_lexem_566_closure" (global $camlStdlib__valid_float_lexem_566_closure))
 (export "camlStdlib__valid_float_lexem_1679" (global $camlStdlib__valid_float_lexem_1679))
 (export "camlStdlib__string_of_float_611_closure" (global $camlStdlib__string_of_float_611_closure))
 (export "camlStdlib__string_of_float_1680" (global $camlStdlib__string_of_float_1680))
 (export "camlStdlib__float_of_string_opt_624_closure" (global $camlStdlib__float_of_string_opt_624_closure))
 (export "camlStdlib__float_of_string_opt_1681" (global $camlStdlib__float_of_string_opt_1681))
 (export "camlStdlib____642_closure" (global $camlStdlib____642_closure))
 (export "camlStdlib__set_of_closures_1682" (global $camlStdlib__set_of_closures_1682))
 (export "camlStdlib__open_out_gen_669_closure" (global $camlStdlib__open_out_gen_669_closure))
 (export "camlStdlib__open_out_gen_1683" (global $camlStdlib__open_out_gen_1683))
 (export "camlStdlib__open_out_683_closure" (global $camlStdlib__open_out_683_closure))
 (export "camlStdlib__open_out_1684" (global $camlStdlib__open_out_1684))
 (export "camlStdlib__open_out_bin_699_closure" (global $camlStdlib__open_out_bin_699_closure))
 (export "camlStdlib__open_out_bin_1685" (global $camlStdlib__open_out_bin_1685))
 (export "camlStdlib__iter_721_closure" (global $camlStdlib__iter_721_closure))
 (export "camlStdlib__set_of_closures_1687" (global $camlStdlib__set_of_closures_1687))
 (export "camlStdlib__flush_all_715_closure" (global $camlStdlib__flush_all_715_closure))
 (export "camlStdlib__flush_all_1686" (global $camlStdlib__flush_all_1686))
 (export "camlStdlib__output_bytes_751_closure" (global $camlStdlib__output_bytes_751_closure))
 (export "camlStdlib__output_bytes_1688" (global $camlStdlib__output_bytes_1688))
 (export "camlStdlib__output_string_763_closure" (global $camlStdlib__output_string_763_closure))
 (export "camlStdlib__output_string_1689" (global $camlStdlib__output_string_1689))
 (export "camlStdlib__Pmakeblock_2443" (global $camlStdlib__Pmakeblock_2443))
 (export "camlStdlib__output_775_closure" (global $camlStdlib__output_775_closure))
 (export "camlStdlib__output_1690" (global $camlStdlib__output_1690))
 (export "camlStdlib__Pmakeblock_2454" (global $camlStdlib__Pmakeblock_2454))
 (export "camlStdlib__output_substring_806_closure" (global $camlStdlib__output_substring_806_closure))
 (export "camlStdlib__output_substring_1691" (global $camlStdlib__output_substring_1691))
 (export "camlStdlib__output_value_837_closure" (global $camlStdlib__output_value_837_closure))
 (export "camlStdlib__output_value_1692" (global $camlStdlib__output_value_1692))
 (export "camlStdlib__close_out_847_closure" (global $camlStdlib__close_out_847_closure))
 (export "camlStdlib__close_out_1693" (global $camlStdlib__close_out_1693))
 (export "camlStdlib__close_out_noerr_856_closure" (global $camlStdlib__close_out_noerr_856_closure))
 (export "camlStdlib__close_out_noerr_1694" (global $camlStdlib__close_out_noerr_1694))
 (export "camlStdlib__open_in_gen_869_closure" (global $camlStdlib__open_in_gen_869_closure))
 (export "camlStdlib__open_in_gen_1695" (global $camlStdlib__open_in_gen_1695))
 (export "camlStdlib__open_in_883_closure" (global $camlStdlib__open_in_883_closure))
 (export "camlStdlib__open_in_1696" (global $camlStdlib__open_in_1696))
 (export "camlStdlib__open_in_bin_897_closure" (global $camlStdlib__open_in_bin_897_closure))
 (export "camlStdlib__open_in_bin_1697" (global $camlStdlib__open_in_bin_1697))
 (export "camlStdlib__Pmakeblock_2450" (global $camlStdlib__Pmakeblock_2450))
 (export "camlStdlib__input_911_closure" (global $camlStdlib__input_911_closure))
 (export "camlStdlib__input_1698" (global $camlStdlib__input_1698))
 (export "camlStdlib__unsafe_really_input_942_closure" (global $camlStdlib__unsafe_really_input_942_closure))
 (export "camlStdlib__set_of_closures_1699" (global $camlStdlib__set_of_closures_1699))
 (export "camlStdlib__Pmakeblock_2451" (global $camlStdlib__Pmakeblock_2451))
 (export "camlStdlib__really_input_969_closure" (global $camlStdlib__really_input_969_closure))
 (export "camlStdlib__really_input_1700" (global $camlStdlib__really_input_1700))
 (export "camlStdlib__really_input_string_1001_closure" (global $camlStdlib__really_input_string_1001_closure))
 (export "camlStdlib__really_input_string_1701" (global $camlStdlib__really_input_string_1701))
 (export "camlStdlib__build_result_1021_closure" (global $camlStdlib__build_result_1021_closure))
 (export "camlStdlib__set_of_closures_1703" (global $camlStdlib__set_of_closures_1703))
 (export "camlStdlib__input_line_1015_closure" (global $camlStdlib__input_line_1015_closure))
 (export "camlStdlib__input_line_1702" (global $camlStdlib__input_line_1702))
 (export "camlStdlib__close_in_noerr_1127_closure" (global $camlStdlib__close_in_noerr_1127_closure))
 (export "camlStdlib__close_in_noerr_1704" (global $camlStdlib__close_in_noerr_1704))
 (export "camlStdlib__string_of_format_1354_closure" (global $camlStdlib__string_of_format_1354_closure))
 (export "camlStdlib__string_of_format_1706" (global $camlStdlib__string_of_format_1706))
 (export "camlStdlib__^^_1361_closure" (global $camlStdlib__^^_1361_closure))
 (export "camlStdlib__^^_1707" (global $camlStdlib__^^_1707))
 (export "camlStdlib__anon_fn_1483_closure" (global $camlStdlib__anon_fn_1483_closure))
 (export "camlStdlib__set_of_closures_1708" (global $camlStdlib__set_of_closures_1708))
 (export "camlStdlib__anon_fn_1632_closure" (global $camlStdlib__anon_fn_1632_closure))
 (export "camlStdlib__set_of_closures_1709" (global $camlStdlib__set_of_closures_1709))
 (export "camlStdlib__anon_fn_1626_closure" (global $camlStdlib__anon_fn_1626_closure))
 (export "camlStdlib__set_of_closures_1710" (global $camlStdlib__set_of_closures_1710))
 (export "camlStdlib__anon_fn_1619_closure" (global $camlStdlib__anon_fn_1619_closure))
 (export "camlStdlib__set_of_closures_1711" (global $camlStdlib__set_of_closures_1711))
 (export "camlStdlib__anon_fn_1613_closure" (global $camlStdlib__anon_fn_1613_closure))
 (export "camlStdlib__set_of_closures_1712" (global $camlStdlib__set_of_closures_1712))
 (export "camlStdlib__anon_fn_1607_closure" (global $camlStdlib__anon_fn_1607_closure))
 (export "camlStdlib__set_of_closures_1713" (global $camlStdlib__set_of_closures_1713))
 (export "camlStdlib__anon_fn_1600_closure" (global $camlStdlib__anon_fn_1600_closure))
 (export "camlStdlib__set_of_closures_1714" (global $camlStdlib__set_of_closures_1714))
 (export "camlStdlib__Pmakeblock_1715" (global $camlStdlib__Pmakeblock_1715))
 (export "camlStdlib__anon_fn_1593_closure" (global $camlStdlib__anon_fn_1593_closure))
 (export "camlStdlib__set_of_closures_1716" (global $camlStdlib__set_of_closures_1716))
 (export "camlStdlib__anon_fn_1587_closure" (global $camlStdlib__anon_fn_1587_closure))
 (export "camlStdlib__set_of_closures_1717" (global $camlStdlib__set_of_closures_1717))
 (export "camlStdlib__anon_fn_1581_closure" (global $camlStdlib__anon_fn_1581_closure))
 (export "camlStdlib__set_of_closures_1718" (global $camlStdlib__set_of_closures_1718))
 (export "camlStdlib__anon_fn_1575_closure" (global $camlStdlib__anon_fn_1575_closure))
 (export "camlStdlib__set_of_closures_1719" (global $camlStdlib__set_of_closures_1719))
 (export "camlStdlib__anon_fn_1568_closure" (global $camlStdlib__anon_fn_1568_closure))
 (export "camlStdlib__set_of_closures_1720" (global $camlStdlib__set_of_closures_1720))
 (export "camlStdlib__anon_fn_1562_closure" (global $camlStdlib__anon_fn_1562_closure))
 (export "camlStdlib__set_of_closures_1721" (global $camlStdlib__set_of_closures_1721))
 (export "camlStdlib__anon_fn_1556_closure" (global $camlStdlib__anon_fn_1556_closure))
 (export "camlStdlib__set_of_closures_1722" (global $camlStdlib__set_of_closures_1722))
 (export "camlStdlib__anon_fn_1550_closure" (global $camlStdlib__anon_fn_1550_closure))
 (export "camlStdlib__set_of_closures_1723" (global $camlStdlib__set_of_closures_1723))
 (export "camlStdlib__anon_fn_1544_closure" (global $camlStdlib__anon_fn_1544_closure))
 (export "camlStdlib__set_of_closures_1724" (global $camlStdlib__set_of_closures_1724))
 (export "camlStdlib__anon_fn_1537_closure" (global $camlStdlib__anon_fn_1537_closure))
 (export "camlStdlib__set_of_closures_1725" (global $camlStdlib__set_of_closures_1725))
 (export "camlStdlib__anon_fn_1531_closure" (global $camlStdlib__anon_fn_1531_closure))
 (export "camlStdlib__set_of_closures_1726" (global $camlStdlib__set_of_closures_1726))
 (export "camlStdlib__anon_fn_1525_closure" (global $camlStdlib__anon_fn_1525_closure))
 (export "camlStdlib__set_of_closures_1727" (global $camlStdlib__set_of_closures_1727))
 (export "camlStdlib__anon_fn_1518_closure" (global $camlStdlib__anon_fn_1518_closure))
 (export "camlStdlib__set_of_closures_1728" (global $camlStdlib__set_of_closures_1728))
 (export "camlStdlib__anon_fn_1511_closure" (global $camlStdlib__anon_fn_1511_closure))
 (export "camlStdlib__set_of_closures_1729" (global $camlStdlib__set_of_closures_1729))
 (export "camlStdlib__anon_fn_1504_closure" (global $camlStdlib__anon_fn_1504_closure))
 (export "camlStdlib__set_of_closures_1730" (global $camlStdlib__set_of_closures_1730))
 (export "camlStdlib__anon_fn_1497_closure" (global $camlStdlib__anon_fn_1497_closure))
 (export "camlStdlib__set_of_closures_1731" (global $camlStdlib__set_of_closures_1731))
 (export "camlStdlib__anon_fn_1491_closure" (global $camlStdlib__anon_fn_1491_closure))
 (export "camlStdlib__set_of_closures_1732" (global $camlStdlib__set_of_closures_1732))
 (export "camlStdlib__Pccall_arg_2827" (global $camlStdlib__Pccall_arg_2827))
 (export "camlStdlib__Pccall_arg_2826" (global $camlStdlib__Pccall_arg_2826))
 (export "camlStdlib__Pccall_arg_2825" (global $camlStdlib__Pccall_arg_2825))
 (export "camlStdlib__Pccall_arg_2824" (global $camlStdlib__Pccall_arg_2824))
 (export "camlStdlib__Pccall_arg_2823" (global $camlStdlib__Pccall_arg_2823))
 (export "camlStdlib__Pccall_arg_2822" (global $camlStdlib__Pccall_arg_2822))
 (export "camlStdlib__Pccall_1862" (global $camlStdlib__Pccall_1862))
 (export "camlStdlib__Pmakeblock_1861" (global $camlStdlib__Pmakeblock_1861))
 (export "camlStdlib__Pccall_1858" (global $camlStdlib__Pccall_1858))
 (export "camlStdlib__Pccall_1857" (global $camlStdlib__Pccall_1857))
 (export "camlStdlib__Pccall_1856" (global $camlStdlib__Pccall_1856))
 (export "camlStdlib__Pccall_1855" (global $camlStdlib__Pccall_1855))
 (export "camlStdlib__Pccall_1854" (global $camlStdlib__Pccall_1854))
 (export "camlStdlib__Pccall_1853" (global $camlStdlib__Pccall_1853))
 (export "camlStdlib__Pccall_1852" (global $camlStdlib__Pccall_1852))
 (export "camlStdlib__Pccall_1851" (global $camlStdlib__Pccall_1851))
 (export "camlStdlib__Pccall_1850" (global $camlStdlib__Pccall_1850))
 (export "camlStdlib__exit_function_1810" (global $camlStdlib__exit_function_1810))
 (export "camlStdlib__do_at_exit_1448_closure" (global $camlStdlib__do_at_exit_1448_closure))
 (export "camlStdlib__do_at_exit_2236" (global $camlStdlib__do_at_exit_2236))
 (export "camlStdlib__Pccall_1802" (global $camlStdlib__Pccall_1802))
 (export "camlStdlib__print_char_1136_closure" (global $camlStdlib__print_char_1136_closure))
 (export "camlStdlib__print_char_2216" (global $camlStdlib__print_char_2216))
 (export "camlStdlib__print_string_1144_closure" (global $camlStdlib__print_string_1144_closure))
 (export "camlStdlib__print_string_2217" (global $camlStdlib__print_string_2217))
 (export "camlStdlib__print_bytes_1153_closure" (global $camlStdlib__print_bytes_1153_closure))
 (export "camlStdlib__print_bytes_2218" (global $camlStdlib__print_bytes_2218))
 (export "camlStdlib__print_int_1162_closure" (global $camlStdlib__print_int_1162_closure))
 (export "camlStdlib__print_int_2219" (global $camlStdlib__print_int_2219))
 (export "camlStdlib__print_float_1174_closure" (global $camlStdlib__print_float_1174_closure))
 (export "camlStdlib__print_float_2220" (global $camlStdlib__print_float_2220))
 (export "camlStdlib__print_endline_1186_closure" (global $camlStdlib__print_endline_1186_closure))
 (export "camlStdlib__print_endline_2221" (global $camlStdlib__print_endline_2221))
 (export "camlStdlib__print_newline_1201_closure" (global $camlStdlib__print_newline_1201_closure))
 (export "camlStdlib__print_newline_2222" (global $camlStdlib__print_newline_2222))
 (export "camlStdlib__prerr_char_1213_closure" (global $camlStdlib__prerr_char_1213_closure))
 (export "camlStdlib__prerr_char_2223" (global $camlStdlib__prerr_char_2223))
 (export "camlStdlib__prerr_string_1221_closure" (global $camlStdlib__prerr_string_1221_closure))
 (export "camlStdlib__prerr_string_2224" (global $camlStdlib__prerr_string_2224))
 (export "camlStdlib__prerr_bytes_1230_closure" (global $camlStdlib__prerr_bytes_1230_closure))
 (export "camlStdlib__prerr_bytes_2225" (global $camlStdlib__prerr_bytes_2225))
 (export "camlStdlib__prerr_int_1239_closure" (global $camlStdlib__prerr_int_1239_closure))
 (export "camlStdlib__prerr_int_2226" (global $camlStdlib__prerr_int_2226))
 (export "camlStdlib__prerr_float_1251_closure" (global $camlStdlib__prerr_float_1251_closure))
 (export "camlStdlib__prerr_float_2227" (global $camlStdlib__prerr_float_2227))
 (export "camlStdlib__prerr_endline_1263_closure" (global $camlStdlib__prerr_endline_1263_closure))
 (export "camlStdlib__prerr_endline_2228" (global $camlStdlib__prerr_endline_2228))
 (export "camlStdlib__prerr_newline_1278_closure" (global $camlStdlib__prerr_newline_1278_closure))
 (export "camlStdlib__prerr_newline_2229" (global $camlStdlib__prerr_newline_2229))
 (export "camlStdlib__read_line_1290_closure" (global $camlStdlib__read_line_1290_closure))
 (export "camlStdlib__read_line_2230" (global $camlStdlib__read_line_2230))
 (export "camlStdlib__read_int_1302_closure" (global $camlStdlib__read_int_1302_closure))
 (export "camlStdlib__read_int_2231" (global $camlStdlib__read_int_2231))
 (export "camlStdlib__read_int_opt_1314_closure" (global $camlStdlib__read_int_opt_1314_closure))
 (export "camlStdlib__read_int_opt_2232" (global $camlStdlib__read_int_opt_2232))
 (export "camlStdlib__read_float_1327_closure" (global $camlStdlib__read_float_1327_closure))
 (export "camlStdlib__read_float_2233" (global $camlStdlib__read_float_2233))
 (export "camlStdlib__read_float_opt_1339_closure" (global $camlStdlib__read_float_opt_1339_closure))
 (export "camlStdlib__read_float_opt_2234" (global $camlStdlib__read_float_opt_2234))
 (export "camlStdlib__at_exit_1395_closure" (global $camlStdlib__at_exit_1395_closure))
 (export "camlStdlib__set_of_closures_2235" (global $camlStdlib__set_of_closures_2235))
 (export "camlStdlib__exit_1461_closure" (global $camlStdlib__exit_1461_closure))
 (export "camlStdlib__exit_2237" (global $camlStdlib__exit_2237))
 (export "camlStdlib" (global $camlStdlib))
 (export "failwith_323" (func $failwith_323))
 (export "invalid_arg_334" (func $invalid_arg_334))
 (export "min_378" (func $min_378))
 (export "max_387" (func $max_387))
 (export "abs_396" (func $abs_396))
 (export "lnot_407" (func $lnot_407))
 (export "^_456" (func $^_456))
 (export "char_of_int_481" (func $char_of_int_481))
 (export "string_of_bool_501" (func $string_of_bool_501))
 (export "bool_of_string_512" (func $bool_of_string_512))
 (export "bool_of_string_opt_526" (func $bool_of_string_opt_526))
 (export "string_of_int_538" (func $string_of_int_538))
 (export "int_of_string_opt_548" (func $int_of_string_opt_548))
 (export "valid_float_lexem_566" (func $valid_float_lexem_566))
 (export "loop_574" (func $loop_574))
 (export "string_of_float_611" (func $string_of_float_611))
 (export "float_of_string_opt_624" (func $float_of_string_opt_624))
 (export "__642" (func $__642))
 (export "open_out_gen_669" (func $open_out_gen_669))
 (export "open_out_683" (func $open_out_683))
 (export "open_out_bin_699" (func $open_out_bin_699))
 (export "iter_721" (func $iter_721))
 (export "flush_all_715" (func $flush_all_715))
 (export "output_bytes_751" (func $output_bytes_751))
 (export "output_string_763" (func $output_string_763))
 (export "output_775" (func $output_775))
 (export "output_substring_806" (func $output_substring_806))
 (export "output_value_837" (func $output_value_837))
 (export "close_out_847" (func $close_out_847))
 (export "close_out_noerr_856" (func $close_out_noerr_856))
 (export "open_in_gen_869" (func $open_in_gen_869))
 (export "open_in_883" (func $open_in_883))
 (export "open_in_bin_897" (func $open_in_bin_897))
 (export "input_911" (func $input_911))
 (export "unsafe_really_input_942" (func $unsafe_really_input_942))
 (export "really_input_969" (func $really_input_969))
 (export "really_input_string_1001" (func $really_input_string_1001))
 (export "build_result_1021" (func $build_result_1021))
 (export "input_line_1015" (func $input_line_1015))
 (export "scan_1045" (func $scan_1045))
 (export "close_in_noerr_1127" (func $close_in_noerr_1127))
 (export "string_of_format_1354" (func $string_of_format_1354))
 (export "^^_1361" (func $^^_1361))
 (export "anon_fn_1483" (func $anon_fn_1483))
 (export "anon_fn_1632" (func $anon_fn_1632))
 (export "anon_fn_1626" (func $anon_fn_1626))
 (export "anon_fn_1619" (func $anon_fn_1619))
 (export "anon_fn_1613" (func $anon_fn_1613))
 (export "anon_fn_1607" (func $anon_fn_1607))
 (export "anon_fn_1600" (func $anon_fn_1600))
 (export "anon_fn_1593" (func $anon_fn_1593))
 (export "anon_fn_1587" (func $anon_fn_1587))
 (export "anon_fn_1581" (func $anon_fn_1581))
 (export "anon_fn_1575" (func $anon_fn_1575))
 (export "anon_fn_1568" (func $anon_fn_1568))
 (export "anon_fn_1562" (func $anon_fn_1562))
 (export "anon_fn_1556" (func $anon_fn_1556))
 (export "anon_fn_1550" (func $anon_fn_1550))
 (export "anon_fn_1544" (func $anon_fn_1544))
 (export "anon_fn_1537" (func $anon_fn_1537))
 (export "anon_fn_1531" (func $anon_fn_1531))
 (export "anon_fn_1525" (func $anon_fn_1525))
 (export "anon_fn_1518" (func $anon_fn_1518))
 (export "anon_fn_1511" (func $anon_fn_1511))
 (export "anon_fn_1504" (func $anon_fn_1504))
 (export "anon_fn_1497" (func $anon_fn_1497))
 (export "anon_fn_1491" (func $anon_fn_1491))
 (export "do_at_exit_1448" (func $do_at_exit_1448))
 (export "print_char_1136" (func $print_char_1136))
 (export "print_string_1144" (func $print_string_1144))
 (export "print_bytes_1153" (func $print_bytes_1153))
 (export "print_int_1162" (func $print_int_1162))
 (export "print_float_1174" (func $print_float_1174))
 (export "print_endline_1186" (func $print_endline_1186))
 (export "print_newline_1201" (func $print_newline_1201))
 (export "prerr_char_1213" (func $prerr_char_1213))
 (export "prerr_string_1221" (func $prerr_string_1221))
 (export "prerr_bytes_1230" (func $prerr_bytes_1230))
 (export "prerr_int_1239" (func $prerr_int_1239))
 (export "prerr_float_1251" (func $prerr_float_1251))
 (export "prerr_endline_1263" (func $prerr_endline_1263))
 (export "prerr_newline_1278" (func $prerr_newline_1278))
 (export "read_line_1290" (func $read_line_1290))
 (export "read_int_1302" (func $read_int_1302))
 (export "read_int_opt_1314" (func $read_int_opt_1314))
 (export "read_float_1327" (func $read_float_1327))
 (export "read_float_opt_1339" (func $read_float_opt_1339))
 (export "at_exit_1395" (func $at_exit_1395))
 (export "new_exit_1413" (func $new_exit_1413))
 (export "exit_1461" (func $exit_1461))
 (export "new_exit_2705" (func $new_exit_2705))
 (export "camlTaku__tak_43_closure" (global $camlTaku__tak_43_closure))
 (export "camlTaku__tak_8_closure" (global $camlTaku__tak_8_closure))
 (export "camlTaku__set_of_closures_84" (global $camlTaku__set_of_closures_84))
 (export "camlTaku__repeat_49_closure" (global $camlTaku__repeat_49_closure))
 (export "camlTaku__set_of_closures_85" (global $camlTaku__set_of_closures_85))
 (export "camlTaku__apply_arg_92" (global $camlTaku__apply_arg_92))
 (export "camlTaku__Pccall_144" (global $camlTaku__Pccall_144))
 (export "camlTaku" (global $camlTaku))
 (export "tak_43" (func $tak_43))
 (export "tak_8" (func $tak_8))
 (export "repeat_49" (func $repeat_49))
 (export "camlStd_exit__simplify_fv_27" (global $camlStd_exit__simplify_fv_27))
 (export "camlStd_exit" (global $camlStd_exit))
 (start $merged.start.old_337)
 (func $0 (type $C_import_func_VV_V) (param $a (ref eq)) (param $b (ref eq)) (result (ref eq))
  (local $a' i32)
  (local $b' i32)
  (local.set $a'
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $a)
    )
   )
  )
  (local.set $b'
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $b)
    )
   )
  )
  (ref.i31
   (i32.sub
    (i32.gt_s
     (local.get $a')
     (local.get $b')
    )
    (i32.lt_s
     (local.get $a')
     (local.get $b')
    )
   )
  )
 )
 (func $1 (type $37) (param $a (ref eq)) (param $b (ref eq)) (result (ref i31))
  (local $a' f64)
  (local $b' f64)
  (local.set $a'
   (struct.get $Float 0
    (ref.cast (ref $Float)
     (local.get $a)
    )
   )
  )
  (local.set $b'
   (struct.get $Float 0
    (ref.cast (ref $Float)
     (local.get $b)
    )
   )
  )
  (ref.i31
   (i32.add
    (i32.sub
     (f64.gt
      (local.get $a')
      (local.get $b')
     )
     (f64.lt
      (local.get $a')
      (local.get $b')
     )
    )
    (i32.sub
     (f64.eq
      (local.get $a')
      (local.get $a')
     )
     (f64.eq
      (local.get $b')
      (local.get $b')
     )
    )
   )
  )
 )
 (func $array_length (type $C_import_func_V_V) (param $arr (ref eq)) (result (ref eq))
  (block $floatarray (result (ref $FloatArray))
   (return
    (ref.i31
     (array.len
      (ref.cast (ref $Array)
       (br_on_cast $floatarray (ref eq) (ref $FloatArray)
        (local.get $arr)
       )
      )
     )
    )
   )
  )
 )
 (func $array_get_float_safe (type $40) (param $arr (ref $FloatArray)) (param $field (ref eq)) (result (ref $Float))
  (struct.new $Float
   (array.get $FloatArray
    (local.get $arr)
    (i31.get_s
     (ref.cast (ref i31)
      (local.get $field)
     )
    )
   )
  )
 )
 (func $2 (type $C_import_func_VV_V) (param $arr (ref eq)) (param $field (ref eq)) (result (ref eq))
  (call $array_get_float_safe
   (ref.cast (ref $FloatArray)
    (local.get $arr)
   )
   (local.get $field)
  )
 )
 (func $array_get_int_or_addr_safe (type $41) (param $arr (ref $Array)) (param $field (ref eq)) (result (ref eq))
  (array.get $Array
   (local.get $arr)
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $field)
    )
   )
  )
 )
 (func $3 (type $C_import_func_VV_V) (param $arr (ref eq)) (param $field (ref eq)) (result (ref eq))
  (call $array_get_int_or_addr_safe
   (ref.cast (ref $Array)
    (local.get $arr)
   )
   (local.get $field)
  )
 )
 (func $array_get_safe (type $C_import_func_VV_V) (param $arr (ref eq)) (param $field (ref eq)) (result (ref eq))
  (return
   (call $array_get_float_safe
    (block $floatarray (result (ref $FloatArray))
     (return
      (call $array_get_int_or_addr_safe
       (ref.cast (ref $Array)
        (br_on_cast $floatarray (ref eq) (ref $FloatArray)
         (local.get $arr)
        )
       )
       (local.get $field)
      )
     )
    )
    (local.get $field)
   )
  )
 )
 (func $array_set_float_unsafe (type $C_import_func_VVV_V) (param $arr (ref eq)) (param $field (ref eq)) (param $value (ref eq)) (result (ref eq))
  (array.set $FloatArray
   (ref.cast (ref $FloatArray)
    (local.get $arr)
   )
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $field)
    )
   )
   (struct.get $Float 0
    (ref.cast (ref $Float)
     (local.get $value)
    )
   )
  )
  (ref.i31
   (i32.const 0)
  )
 )
 (func $array_set_int_or_addr_unsafe (type $C_import_func_VVV_V) (param $arr (ref eq)) (param $field (ref eq)) (param $value (ref eq)) (result (ref eq))
  (array.set $Array
   (ref.cast (ref $Array)
    (local.get $arr)
   )
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $field)
    )
   )
   (local.get $value)
  )
  (ref.i31
   (i32.const 0)
  )
 )
 (func $array_set_unsafe (type $C_import_func_VVV_V) (param $arr (ref eq)) (param $field (ref eq)) (param $value (ref eq)) (result (ref eq))
  (return
   (call $array_set_float_unsafe
    (block $floatarray (result (ref $FloatArray))
     (return
      (call $array_set_int_or_addr_unsafe
       (ref.cast (ref $Array)
        (br_on_cast $floatarray (ref eq) (ref $FloatArray)
         (local.get $arr)
        )
       )
       (local.get $field)
       (local.get $value)
      )
     )
    )
    (local.get $field)
    (local.get $value)
   )
  )
 )
 (func $4 (type $C_import_func_VVV_V) (param $arr (ref eq)) (param $field (ref eq)) (param $value (ref eq)) (result (ref eq))
  (call $array_set_unsafe
   (local.get $arr)
   (local.get $field)
   (local.get $value)
  )
 )
 (func $5 (type $C_import_func_V_V) (param $src (ref eq)) (result (ref eq))
  (local $a (ref $Array))
  (local $dst (ref $Array))
  (local.set $a
   (ref.cast (ref $Array)
    (local.get $src)
   )
  )
  (local.set $dst
   (array.new $Array
    (ref.i31
     (i32.const 42)
    )
    (i32.add
     (i32.const -1)
     (array.len
      (local.get $a)
     )
    )
   )
  )
  (array.copy $Array $Array
   (local.get $dst)
   (i32.const 0)
   (local.get $a)
   (i32.const 1)
   (i32.add
    (i32.const -1)
    (array.len
     (local.get $a)
    )
   )
  )
  (local.get $dst)
 )
 (func $6 (type $C_import_func_VVV_V) (param $arr (ref eq)) (param $field (ref eq)) (param $value (ref eq)) (result (ref eq))
  (array.set $String
   (ref.cast (ref $String)
    (local.get $arr)
   )
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $field)
    )
   )
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $value)
    )
   )
  )
  (ref.i31
   (i32.const 0)
  )
 )
 (func $7 (type $C_import_func_VV_V) (param $arr (ref eq)) (param $field_i31 (ref eq)) (result (ref eq))
  (local $field i32)
  (local.set $field
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $field_i31)
    )
   )
  )
  (if (result (ref i31))
   (i32.lt_s
    (local.get $field)
    (array.len
     (ref.cast (ref $String)
      (local.get $arr)
     )
    )
   )
   (then
    (ref.i31
     (array.get_s $String
      (ref.cast (ref $String)
       (local.get $arr)
      )
      (local.get $field)
     )
    )
   )
   (else
    (call $print_string_23
     (array.new_fixed $String 10
      (i32.const 115)
      (i32.const 116)
      (i32.const 114)
      (i32.const 105)
      (i32.const 110)
      (i32.const 103)
      (i32.const 95)
      (i32.const 103)
      (i32.const 101)
      (i32.const 116)
     )
    )
    (unreachable)
   )
  )
 )
 (func $string_eq (type $35) (param $a (ref $String)) (param $b (ref $String)) (result i32)
  (local $len_a i32)
  (local $len_b i32)
  (local $pos i32)
  (local.set $len_a
   (array.len
    (local.get $a)
   )
  )
  (local.set $len_b
   (array.len
    (local.get $b)
   )
  )
  (if
   (i32.ne
    (local.get $len_a)
    (local.get $len_b)
   )
   (then
    (return
     (i32.const 0)
    )
   )
   (else
    (nop)
   )
  )
  (local.set $pos
   (i32.const 0)
  )
  (loop $next_char
   (if
    (i32.eq
     (local.get $len_a)
     (local.get $pos)
    )
    (then
     (return
      (i32.const 1)
     )
    )
    (else
     (nop)
    )
   )
   (if
    (i32.ne
     (array.get_s $String
      (local.get $a)
      (local.get $pos)
     )
     (array.get_s $String
      (local.get $b)
      (local.get $pos)
     )
    )
    (then
     (return
      (i32.const 0)
     )
    )
    (else
     (local.set $pos
      (i32.add
       (i32.const 1)
       (local.get $pos)
      )
     )
     (br $next_char)
    )
   )
  )
  (call $print_string_23
   (array.new_fixed $String 9
    (i32.const 115)
    (i32.const 116)
    (i32.const 114)
    (i32.const 105)
    (i32.const 110)
    (i32.const 103)
    (i32.const 95)
    (i32.const 101)
    (i32.const 113)
   )
  )
  (unreachable)
 )
 (func $string_neq (type $35) (param $a (ref $String)) (param $b (ref $String)) (result i32)
  (i32.eqz
   (call $string_eq
    (local.get $a)
    (local.get $b)
   )
  )
 )
 (func $8 (type $C_import_func_VV_V) (param $a (ref eq)) (param $b (ref eq)) (result (ref eq))
  (ref.i31
   (call $string_eq
    (ref.cast (ref $String)
     (local.get $a)
    )
    (ref.cast (ref $String)
     (local.get $b)
    )
   )
  )
 )
 (func $9 (type $C_import_func_VV_V) (param $a (ref eq)) (param $b (ref eq)) (result (ref eq))
  (ref.i31
   (call $string_neq
    (ref.cast (ref $String)
     (local.get $a)
    )
    (ref.cast (ref $String)
     (local.get $b)
    )
   )
  )
 )
 (func $10 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 15
    (i32.const 117)
    (i32.const 110)
    (i32.const 105)
    (i32.const 109)
    (i32.const 112)
    (i32.const 108)
    (i32.const 101)
    (i32.const 109)
    (i32.const 101)
    (i32.const 110)
    (i32.const 116)
    (i32.const 101)
    (i32.const 100)
    (i32.const 95)
    (i32.const 49)
   )
  )
  (unreachable)
 )
 (func $11 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 15
    (i32.const 117)
    (i32.const 110)
    (i32.const 105)
    (i32.const 109)
    (i32.const 112)
    (i32.const 108)
    (i32.const 101)
    (i32.const 109)
    (i32.const 101)
    (i32.const 110)
    (i32.const 116)
    (i32.const 101)
    (i32.const 100)
    (i32.const 95)
    (i32.const 50)
   )
  )
  (unreachable)
 )
 (func $12 (type $C_import_func_VVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 15
    (i32.const 117)
    (i32.const 110)
    (i32.const 105)
    (i32.const 109)
    (i32.const 112)
    (i32.const 108)
    (i32.const 101)
    (i32.const 109)
    (i32.const 101)
    (i32.const 110)
    (i32.const 116)
    (i32.const 101)
    (i32.const 100)
    (i32.const 95)
    (i32.const 51)
   )
  )
  (unreachable)
 )
 (func $print_string_23 (type $43) (param $s (ref $String))
  (local $i i32)
  (local.set $i
   (array.len
    (local.get $s)
   )
  )
  (block $stop
   (loop $loop
    (br_if $stop
     (i32.eqz
      (local.get $i)
     )
    )
    (local.set $i
     (i32.sub
      (local.get $i)
      (i32.const 1)
     )
    )
    (call $putchar
     (array.get_u $String
      (local.get $s)
      (local.get $i)
     )
    )
    (br $loop)
   )
  )
 )
 (func $0_23 (type $44) (param $x (ref eq)) (result (ref $Float))
  (struct.new $Float
   (f64.reinterpret_i64
    (struct.get $Int64 0
     (ref.cast (ref $Int64)
      (local.get $x)
     )
    )
   )
  )
 )
 (func $1_23 (type $C_import_func_6_F) (param $x i64) (result f64)
  (f64.reinterpret_i64
   (local.get $x)
  )
 )
 (func $C_caml_obj_tag (type $C_import_func_V_V) (param $obj (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 7
    (i32.const 111)
    (i32.const 98)
    (i32.const 106)
    (i32.const 46)
    (i32.const 116)
    (i32.const 97)
    (i32.const 103)
   )
  )
  (unreachable)
 )
 (func $C_caml_obj_make_forward (type $C_import_func_VV_V) (param $a (ref eq)) (param $b (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 21
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 111)
    (i32.const 98)
    (i32.const 106)
    (i32.const 95)
    (i32.const 109)
    (i32.const 97)
    (i32.const 107)
    (i32.const 101)
    (i32.const 95)
    (i32.const 102)
    (i32.const 111)
    (i32.const 114)
    (i32.const 119)
    (i32.const 97)
    (i32.const 114)
    (i32.const 100)
   )
  )
  (unreachable)
 )
 (func $C_caml_lazy_make_forward (type $C_import_func_V_V) (param $a (ref eq)) (result (ref eq))
  (drop
   (array.new_fixed $String 22
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 108)
    (i32.const 97)
    (i32.const 122)
    (i32.const 121)
    (i32.const 95)
    (i32.const 109)
    (i32.const 97)
    (i32.const 107)
    (i32.const 101)
    (i32.const 95)
    (i32.const 102)
    (i32.const 111)
    (i32.const 114)
    (i32.const 119)
    (i32.const 97)
    (i32.const 114)
    (i32.const 100)
   )
  )
  (unreachable)
 )
 (func $C_caml_obj_block (type $C_import_func_VV_V) (param $tag (ref eq)) (param $size (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 14
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 111)
    (i32.const 98)
    (i32.const 106)
    (i32.const 95)
    (i32.const 98)
    (i32.const 108)
    (i32.const 111)
    (i32.const 99)
    (i32.const 107)
   )
  )
  (unreachable)
 )
 (func $2_23 (type $C_import_func_V_V) (param $unit (ref eq)) (result (ref eq))
  (local $oo_id i32)
  (global.set $oo_id
   (i32.add
    (i32.const 1)
    (local.tee $oo_id
     (global.get $oo_id)
    )
   )
  )
  (ref.i31
   (local.get $oo_id)
  )
 )
 (func $C_atan2 (type $33) (param $0 f64) (param $1 f64) (result f64)
  (call $atan2
   (local.get $1)
   (local.get $0)
  )
 )
 (func $C_sqrt (type $28) (param $0 f64) (result f64)
  (f64.sqrt
   (local.get $0)
  )
 )
 (func $C_sin (type $28) (param $0 f64) (result f64)
  (call $sin
   (local.get $0)
  )
 )
 (func $C_cos (type $28) (param $0 f64) (result f64)
  (call $cos
   (local.get $0)
  )
 )
 (func $C_asin (type $28) (param $0 f64) (result f64)
  (call $asin
   (local.get $0)
  )
 )
 (func $C_fmod (type $33) (param $0 f64) (param $1 f64) (result f64)
  (call $fmod
   (local.get $1)
   (local.get $0)
  )
 )
 (func $3_23 (type $C_import_func_V_V) (param $size (ref eq)) (result (ref eq))
  (array.new_default $String
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $size)
    )
   )
  )
 )
 (func $caml_fill_bytes (type $46) (param $arr (ref $String)) (param $off i32) (param $length i32) (param $value i32)
  (block $break
   (loop $continue
    (br_if $break
     (i32.le_s
      (local.get $length)
      (i32.const 0)
     )
    )
    (array.set $String
     (local.get $arr)
     (local.get $off)
     (local.get $value)
    )
    (local.set $off
     (i32.add
      (local.get $off)
      (i32.const 1)
     )
    )
    (local.set $length
     (i32.sub
      (local.get $length)
      (i32.const 1)
     )
    )
    (br $continue)
   )
  )
 )
 (func $4_23 (type $C_import_func_VVVV_V) (param $arr (ref eq)) (param $off (ref eq)) (param $length (ref eq)) (param $value (ref eq)) (result (ref eq))
  (call $caml_fill_bytes
   (ref.cast (ref $String)
    (local.get $arr)
   )
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $off)
    )
   )
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $length)
    )
   )
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $value)
    )
   )
  )
  (ref.i31
   (i32.const 0)
  )
 )
 (func $compare_strings (type $35) (param $s1 (ref $String)) (param $s2 (ref $String)) (result i32)
  (local $l1 i32)
  (local $l2 i32)
  (local $len i32)
  (local $i i32)
  (local $c1 i32)
  (local $c2 i32)
  (if
   (ref.eq
    (local.get $s1)
    (local.get $s2)
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (local.set $l1
   (array.len
    (local.get $s1)
   )
  )
  (local.set $l2
   (array.len
    (local.get $s2)
   )
  )
  (local.set $len
   (select
    (local.get $l1)
    (local.get $l2)
    (i32.le_u
     (local.get $l1)
     (local.get $l2)
    )
   )
  )
  (local.set $i
   (i32.const 0)
  )
  (loop $loop
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $len)
    )
    (then
     (local.set $c1
      (array.get_u $String
       (local.get $s1)
       (local.get $i)
      )
     )
     (local.set $c2
      (array.get_u $String
       (local.get $s2)
       (local.get $i)
      )
     )
     (if
      (i32.ne
       (local.get $c1)
       (local.get $c2)
      )
      (then
       (if
        (i32.le_u
         (local.get $c1)
         (local.get $c2)
        )
        (then
         (return
          (i32.const -1)
         )
        )
        (else
         (return
          (i32.const 1)
         )
        )
       )
      )
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $loop)
    )
   )
  )
  (i32.sub
   (local.get $l1)
   (local.get $l2)
  )
 )
 (func $caml_string_compare (type $C_import_func_VV_V) (param $a (ref eq)) (param $b (ref eq)) (result (ref eq))
  (ref.i31
   (call $compare_strings
    (ref.cast (ref $String)
     (local.get $a)
    )
    (ref.cast (ref $String)
     (local.get $b)
    )
   )
  )
 )
 (func $5_23 (type $C_import_func_VVVVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (param $3 (ref eq)) (param $4 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 16
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 98)
    (i32.const 108)
    (i32.const 105)
    (i32.const 116)
    (i32.const 95)
    (i32.const 115)
    (i32.const 116)
    (i32.const 114)
    (i32.const 105)
    (i32.const 110)
    (i32.const 103)
   )
  )
  (unreachable)
 )
 (func $6_23 (type $C_import_func_VVVVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (param $3 (ref eq)) (param $4 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 15
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 98)
    (i32.const 108)
    (i32.const 105)
    (i32.const 116)
    (i32.const 95)
    (i32.const 98)
    (i32.const 121)
    (i32.const 116)
    (i32.const 101)
    (i32.const 115)
   )
  )
  (unreachable)
 )
 (func $7_23 (type $47) (param $0 f64) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 27
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 99)
    (i32.const 108)
    (i32.const 97)
    (i32.const 115)
    (i32.const 115)
    (i32.const 105)
    (i32.const 102)
    (i32.const 121)
    (i32.const 95)
    (i32.const 102)
    (i32.const 108)
    (i32.const 111)
    (i32.const 97)
    (i32.const 116)
    (i32.const 95)
    (i32.const 117)
    (i32.const 110)
    (i32.const 98)
    (i32.const 111)
    (i32.const 120)
    (i32.const 101)
    (i32.const 100)
   )
  )
  (unreachable)
 )
 (func $compare (type $C_import_func_VV_V) (param $a (ref eq)) (param $b (ref eq)) (result (ref eq))
  (local $a_block (ref $Array))
  (local $b_block (ref $Array))
  (if (result (ref i31))
   (ref.test (ref i31)
    (local.get $a)
   )
   (then
    (if (result (ref i31))
     (ref.test (ref i31)
      (local.get $b)
     )
     (then
      (return_call $0
       (local.get $a)
       (local.get $b)
      )
     )
     (else
      (ref.i31
       (i32.const -1)
      )
     )
    )
   )
   (else
    (if (result (ref i31))
     (ref.test (ref i31)
      (local.get $b)
     )
     (then
      (ref.i31
       (i32.const 1)
      )
     )
     (else
      (local.set $b_block
       (block $both_block (result (ref $Array))
        (local.set $a_block
         (block $a_is_block (result (ref $Array))
          (drop
           (br_on_cast $a_is_block (ref eq) (ref $Array)
            (local.get $a)
           )
          )
          (return_call $caml_compare_data_non_block
           (local.get $a)
           (local.get $b)
          )
         )
        )
        (drop
         (br_on_cast $both_block (ref eq) (ref $Array)
          (local.get $b)
         )
        )
        (return
         (ref.i31
          (i32.const -1)
         )
        )
       )
      )
      (local.set $a_block
       (ref.cast (ref $Array)
        (local.get $a)
       )
      )
      (return_call $caml_compare_blocks
       (local.get $a_block)
       (local.get $b_block)
      )
     )
    )
   )
  )
 )
 (func $caml_compare_data_non_block (type $C_import_func_VV_V) (param $a (ref eq)) (param $b (ref eq)) (result (ref eq))
  (return_call $caml_string_compare
   (local.get $a)
   (local.get $b)
  )
 )
 (func $caml_compare_blocks (type $39) (param $a (ref $Array)) (param $b (ref $Array)) (result (ref i31))
  (local $len_a i32)
  (local $len_b i32)
  (local.set $len_a
   (array.len
    (local.get $a)
   )
  )
  (local.set $len_b
   (array.len
    (local.get $b)
   )
  )
  (if
   (i32.ne
    (local.get $len_a)
    (local.get $len_b)
   )
   (then
    (return
     (ref.i31
      (i32.sub
       (i32.gt_s
        (local.get $len_a)
        (local.get $len_b)
       )
       (i32.lt_s
        (local.get $len_a)
        (local.get $len_b)
       )
      )
     )
    )
   )
  )
  (call $print_string_23
   (array.new_fixed $String 19
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 99)
    (i32.const 111)
    (i32.const 109)
    (i32.const 112)
    (i32.const 97)
    (i32.const 114)
    (i32.const 101)
    (i32.const 95)
    (i32.const 98)
    (i32.const 108)
    (i32.const 111)
    (i32.const 99)
    (i32.const 107)
    (i32.const 115)
   )
  )
  (unreachable)
 )
 (func $caml_equal (type $C_import_func_VV_V) (param $a (ref eq)) (param $b (ref eq)) (result (ref eq))
  (local $a_block (ref $Array))
  (local $b_block (ref $Array))
  (if (result (ref i31))
   (ref.test (ref i31)
    (local.get $a)
   )
   (then
    (if (result (ref i31))
     (ref.test (ref i31)
      (local.get $b)
     )
     (then
      (ref.i31
       (ref.eq
        (local.get $a)
        (local.get $b)
       )
      )
     )
     (else
      (ref.i31
       (i32.const 0)
      )
     )
    )
   )
   (else
    (if (result (ref i31))
     (ref.test (ref i31)
      (local.get $b)
     )
     (then
      (ref.i31
       (i32.const 0)
      )
     )
     (else
      (local.set $b_block
       (block $both_block (result (ref $Array))
        (local.set $a_block
         (block $a_is_block (result (ref $Array))
          (drop
           (br_on_cast $a_is_block (ref eq) (ref $Array)
            (local.get $a)
           )
          )
          (return_call $equal_data_non_block
           (local.get $a)
           (local.get $b)
          )
         )
        )
        (drop
         (local.get $a_block)
        )
        (drop
         (br_on_cast $both_block (ref eq) (ref $Array)
          (local.get $b)
         )
        )
        (return
         (ref.i31
          (i32.const 0)
         )
        )
       )
      )
      (local.set $a_block
       (ref.cast (ref $Array)
        (local.get $a)
       )
      )
      (return_call $equal_blocks
       (local.get $a_block)
       (local.get $b_block)
      )
     )
    )
   )
  )
 )
 (func $equal_data_non_block (type $37) (param $a (ref eq)) (param $b (ref eq)) (result (ref i31))
  (ref.i31
   (i32.eq
    (i32.const 0)
    (call $compare_strings
     (ref.cast (ref $String)
      (local.get $a)
     )
     (ref.cast (ref $String)
      (local.get $b)
     )
    )
   )
  )
 )
 (func $equal_blocks (type $39) (param $a (ref $Array)) (param $b (ref $Array)) (result (ref i31))
  (local $len_a i32)
  (local $len_b i32)
  (local $v_a (ref eq))
  (local $v_b (ref eq))
  (local $i i32)
  (local.set $len_a
   (array.len
    (local.get $a)
   )
  )
  (local.set $len_b
   (array.len
    (local.get $b)
   )
  )
  (if
   (i32.ne
    (local.get $len_a)
    (local.get $len_b)
   )
   (then
    (return
     (ref.i31
      (i32.const 0)
     )
    )
   )
  )
  (loop $loop
   (if
    (i32.eq
     (local.get $i)
     (local.get $len_a)
    )
    (then
     (return
      (ref.i31
       (i32.const 1)
      )
     )
    )
   )
   (local.set $v_a
    (array.get $Array
     (local.get $a)
     (local.get $i)
    )
   )
   (local.set $v_b
    (array.get $Array
     (local.get $b)
     (local.get $i)
    )
   )
   (if
    (ref.eq
     (ref.i31
      (i32.const 0)
     )
     (call $caml_equal
      (local.get $v_a)
      (local.get $v_b)
     )
    )
    (then
     (return
      (ref.i31
       (i32.const 0)
      )
     )
    )
   )
   (local.set $i
    (i32.add
     (i32.const 1)
     (local.get $i)
    )
   )
   (br $loop)
  )
 )
 (func $8_23 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (ref.i31
   (i32.eqz
    (i31.get_s
     (ref.cast (ref i31)
      (call $caml_equal
       (local.get $0)
       (local.get $1)
      )
     )
    )
   )
  )
 )
 (func $9_23 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (ref.i31
   (i32.le_s
    (i31.get_s
     (ref.cast (ref i31)
      (call $compare
       (local.get $0)
       (local.get $1)
      )
     )
    )
    (i32.const 0)
   )
  )
 )
 (func $10_23 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (ref.i31
   (i32.ge_s
    (i31.get_s
     (ref.cast (ref i31)
      (call $compare
       (local.get $0)
       (local.get $1)
      )
     )
    )
    (i32.const 0)
   )
  )
 )
 (func $C_caml_greaterthan (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (ref.i31
   (i32.gt_s
    (i31.get_s
     (ref.cast (ref i31)
      (call $compare
       (local.get $0)
       (local.get $1)
      )
     )
    )
    (i32.const 0)
   )
  )
 )
 (func $C_caml_lessthan (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (ref.i31
   (i32.lt_s
    (i31.get_s
     (ref.cast (ref i31)
      (call $compare
       (local.get $0)
       (local.get $1)
      )
     )
    )
    (i32.const 0)
   )
  )
 )
 (func $format_int_default (type $48) (param $d i32) (result (ref eq))
  (local $s (ref $String))
  (local $negative i32)
  (local $i i32)
  (local $n i32)
  (if
   (i32.lt_s
    (local.get $d)
    (i32.const 0)
   )
   (then
    (local.set $negative
     (i32.const 1)
    )
    (local.set $i
     (i32.const 1)
    )
    (local.set $d
     (i32.sub
      (i32.const 0)
      (local.get $d)
     )
    )
   )
  )
  (local.set $n
   (local.get $d)
  )
  (loop $count
   (local.set $i
    (i32.add
     (local.get $i)
     (i32.const 1)
    )
   )
   (local.set $n
    (i32.div_u
     (local.get $n)
     (i32.const 10)
    )
   )
   (br_if $count
    (local.get $n)
   )
  )
  (local.set $s
   (array.new $String
    (i32.const 0)
    (local.get $i)
   )
  )
  (loop $write
   (local.set $i
    (i32.sub
     (local.get $i)
     (i32.const 1)
    )
   )
   (array.set $String
    (local.get $s)
    (local.get $i)
    (i32.add
     (i32.const 48)
     (i32.rem_u
      (local.get $d)
      (i32.const 10)
     )
    )
   )
   (local.set $d
    (i32.div_u
     (local.get $d)
     (i32.const 10)
    )
   )
   (br_if $write
    (local.get $d)
   )
  )
  (if
   (local.get $negative)
   (then
    (array.set $String
     (local.get $s)
     (i32.const 0)
     (i32.const 45)
    )
   )
  )
  (local.get $s)
 )
 (func $11_23 (type $C_import_func_VV_V) (param $format (ref eq)) (param $d (ref eq)) (result (ref eq))
  (call $format_int_default
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $d)
    )
   )
  )
 )
 (func $12_23 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 17
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 102)
    (i32.const 111)
    (i32.const 114)
    (i32.const 109)
    (i32.const 97)
    (i32.const 116)
    (i32.const 95)
    (i32.const 102)
    (i32.const 108)
    (i32.const 111)
    (i32.const 97)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $13 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 18
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 105)
    (i32.const 110)
    (i32.const 116)
    (i32.const 95)
    (i32.const 111)
    (i32.const 102)
    (i32.const 95)
    (i32.const 115)
    (i32.const 116)
    (i32.const 114)
    (i32.const 105)
    (i32.const 110)
    (i32.const 103)
   )
  )
  (unreachable)
 )
 (func $14 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 20
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 102)
    (i32.const 108)
    (i32.const 111)
    (i32.const 97)
    (i32.const 116)
    (i32.const 95)
    (i32.const 111)
    (i32.const 102)
    (i32.const 95)
    (i32.const 115)
    (i32.const 116)
    (i32.const 114)
    (i32.const 105)
    (i32.const 110)
    (i32.const 103)
   )
  )
  (unreachable)
 )
 (func $15 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (ref.cast (ref i31)
   (local.get $0)
  )
 )
 (func $16 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (ref.cast (ref i31)
   (local.get $0)
  )
 )
 (func $17 (type $C_import_func_VVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 13
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 115)
    (i32.const 121)
    (i32.const 115)
    (i32.const 95)
    (i32.const 111)
    (i32.const 112)
    (i32.const 101)
    (i32.const 110)
   )
  )
  (unreachable)
 )
 (func $18 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $flush)
  (ref.i31
   (i32.const 0)
  )
 )
 (func $cons (type $49) (param $h (ref eq)) (param $t (ref eq)) (result (ref $Array))
  (array.new_fixed $Array 3
   (ref.i31
    (i32.const 0)
   )
   (local.get $h)
   (local.get $t)
  )
 )
 (func $19 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $cons
   (ref.i31
    (i32.const 0)
   )
   (global.get $empty_list)
  )
 )
 (func $caml_ml_output (type $C_import_func_VVVV_V) (param $ch (ref eq)) (param $s (ref eq)) (param $vpos (ref eq)) (param $vlen (ref eq)) (result (ref eq))
  (local $pos i32)
  (local $len i32)
  (local.set $pos
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $vpos)
    )
   )
  )
  (local.set $len
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $vlen)
    )
   )
  )
  (loop $loop
   (if
    (i32.gt_s
     (local.get $len)
     (i32.const 0)
    )
    (then
     (call $putchar
      (array.get_u $String
       (ref.cast (ref $String)
        (local.get $s)
       )
       (local.get $pos)
      )
     )
     (local.set $pos
      (i32.add
       (local.get $pos)
       (i32.const 1)
      )
     )
     (local.set $len
      (i32.sub
       (local.get $len)
       (i32.const 1)
      )
     )
     (br $loop)
    )
   )
  )
  (ref.i31
   (i32.const 0)
  )
 )
 (func $20 (type $C_import_func_VVVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (param $3 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 17
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 111)
    (i32.const 117)
    (i32.const 116)
    (i32.const 112)
    (i32.const 117)
    (i32.const 116)
    (i32.const 95)
    (i32.const 98)
    (i32.const 121)
    (i32.const 116)
    (i32.const 101)
    (i32.const 115)
   )
  )
  (unreachable)
 )
 (func $21 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 15
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 111)
    (i32.const 117)
    (i32.const 116)
    (i32.const 112)
    (i32.const 117)
    (i32.const 116)
    (i32.const 95)
    (i32.const 105)
    (i32.const 110)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $22 (type $C_import_func_VV_V) (param $ch (ref eq)) (param $char (ref eq)) (result (ref eq))
  (call $putchar
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $char)
    )
   )
  )
  (ref.i31
   (i32.const 0)
  )
 )
 (func $23 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 18
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 111)
    (i32.const 117)
    (i32.const 116)
    (i32.const 112)
    (i32.const 117)
    (i32.const 116)
    (i32.const 95)
    (i32.const 115)
    (i32.const 116)
    (i32.const 114)
    (i32.const 105)
    (i32.const 110)
    (i32.const 103)
   )
  )
  (unreachable)
 )
 (func $24 (type $C_import_func_VVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 17
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 111)
    (i32.const 117)
    (i32.const 116)
    (i32.const 112)
    (i32.const 117)
    (i32.const 116)
    (i32.const 95)
    (i32.const 118)
    (i32.const 97)
    (i32.const 108)
    (i32.const 117)
    (i32.const 101)
   )
  )
  (unreachable)
 )
 (func $25 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 13
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 115)
    (i32.const 101)
    (i32.const 101)
    (i32.const 107)
    (i32.const 95)
    (i32.const 111)
    (i32.const 117)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $26 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 16
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 115)
    (i32.const 101)
    (i32.const 101)
    (i32.const 107)
    (i32.const 95)
    (i32.const 111)
    (i32.const 117)
    (i32.const 116)
    (i32.const 95)
    (i32.const 54)
    (i32.const 52)
   )
  )
  (unreachable)
 )
 (func $27 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $28 (type $C_import_func_VVVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (param $3 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $29 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $30 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $31 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $32 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $33 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $34 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $35 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $36 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $37 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $38 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $39 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $40 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $41 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $42 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $43 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $44 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (ref.i31
   (i32.const 0)
  )
 )
 (func $C_caml_sys_getenv (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (unreachable)
 )
 (func $C_caml_sys_get_config (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (array.new_fixed $Array 4
   (ref.i31
    (i32.const 0)
   )
   (global.get $os_type)
   (ref.i31
    (i32.const 32)
   )
   (ref.i31
    (i32.const 0)
   )
  )
 )
 (func $C_caml_sys_executable_name (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (global.get $executable_name)
 )
 (func $C_caml_ml_runtime_warnings_enabled (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 32
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 114)
    (i32.const 117)
    (i32.const 110)
    (i32.const 116)
    (i32.const 105)
    (i32.const 109)
    (i32.const 101)
    (i32.const 95)
    (i32.const 119)
    (i32.const 97)
    (i32.const 114)
    (i32.const 110)
    (i32.const 105)
    (i32.const 110)
    (i32.const 103)
    (i32.const 115)
    (i32.const 95)
    (i32.const 101)
    (i32.const 110)
    (i32.const 97)
    (i32.const 98)
    (i32.const 108)
    (i32.const 101)
    (i32.const 100)
   )
  )
  (unreachable)
 )
 (func $C_caml_ml_enable_runtime_warnings (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 31
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 110)
    (i32.const 97)
    (i32.const 98)
    (i32.const 108)
    (i32.const 101)
    (i32.const 95)
    (i32.const 114)
    (i32.const 117)
    (i32.const 110)
    (i32.const 116)
    (i32.const 105)
    (i32.const 109)
    (i32.const 101)
    (i32.const 95)
    (i32.const 119)
    (i32.const 97)
    (i32.const 114)
    (i32.const 110)
    (i32.const 105)
    (i32.const 110)
    (i32.const 103)
    (i32.const 115)
   )
  )
  (unreachable)
 )
 (func $C_caml_install_signal_handler (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 27
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 105)
    (i32.const 110)
    (i32.const 115)
    (i32.const 116)
    (i32.const 97)
    (i32.const 108)
    (i32.const 108)
    (i32.const 95)
    (i32.const 115)
    (i32.const 105)
    (i32.const 103)
    (i32.const 110)
    (i32.const 97)
    (i32.const 108)
    (i32.const 95)
    (i32.const 104)
    (i32.const 97)
    (i32.const 110)
    (i32.const 100)
    (i32.const 108)
    (i32.const 101)
    (i32.const 114)
   )
  )
  (unreachable)
 )
 (func $C_caml_obj_raw_field (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 18
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 111)
    (i32.const 98)
    (i32.const 106)
    (i32.const 95)
    (i32.const 114)
    (i32.const 97)
    (i32.const 119)
    (i32.const 95)
    (i32.const 102)
    (i32.const 105)
    (i32.const 101)
    (i32.const 108)
    (i32.const 100)
   )
  )
  (unreachable)
 )
 (func $C_caml_floatarray_set (type $C_import_func_VVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 19
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 102)
    (i32.const 108)
    (i32.const 111)
    (i32.const 97)
    (i32.const 116)
    (i32.const 97)
    (i32.const 114)
    (i32.const 114)
    (i32.const 97)
    (i32.const 121)
    (i32.const 95)
    (i32.const 115)
    (i32.const 101)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $C_caml_floatarray_get (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 19
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 102)
    (i32.const 108)
    (i32.const 111)
    (i32.const 97)
    (i32.const 116)
    (i32.const 97)
    (i32.const 114)
    (i32.const 114)
    (i32.const 97)
    (i32.const 121)
    (i32.const 95)
    (i32.const 103)
    (i32.const 101)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_unset_key (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 19
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 117)
    (i32.const 110)
    (i32.const 115)
    (i32.const 101)
    (i32.const 116)
    (i32.const 95)
    (i32.const 107)
    (i32.const 101)
    (i32.const 121)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_unset_data (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 20
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 117)
    (i32.const 110)
    (i32.const 115)
    (i32.const 101)
    (i32.const 116)
    (i32.const 95)
    (i32.const 100)
    (i32.const 97)
    (i32.const 116)
    (i32.const 97)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_set_key (type $C_import_func_VVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 17
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 115)
    (i32.const 101)
    (i32.const 116)
    (i32.const 95)
    (i32.const 107)
    (i32.const 101)
    (i32.const 121)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_set_data (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 18
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 115)
    (i32.const 101)
    (i32.const 116)
    (i32.const 95)
    (i32.const 100)
    (i32.const 97)
    (i32.const 116)
    (i32.const 97)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_get_key_copy (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 18
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 103)
    (i32.const 101)
    (i32.const 116)
    (i32.const 95)
    (i32.const 99)
    (i32.const 111)
    (i32.const 112)
    (i32.const 121)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_get_key (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 17
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 103)
    (i32.const 101)
    (i32.const 116)
    (i32.const 95)
    (i32.const 107)
    (i32.const 101)
    (i32.const 121)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_get_data_copy (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 23
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 103)
    (i32.const 101)
    (i32.const 116)
    (i32.const 95)
    (i32.const 100)
    (i32.const 97)
    (i32.const 116)
    (i32.const 97)
    (i32.const 95)
    (i32.const 99)
    (i32.const 111)
    (i32.const 112)
    (i32.const 121)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_get_data (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 18
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 103)
    (i32.const 101)
    (i32.const 116)
    (i32.const 95)
    (i32.const 100)
    (i32.const 97)
    (i32.const 116)
    (i32.const 97)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_create (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 16
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 99)
    (i32.const 114)
    (i32.const 101)
    (i32.const 97)
    (i32.const 116)
    (i32.const 101)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_check_key (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 19
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 99)
    (i32.const 104)
    (i32.const 101)
    (i32.const 99)
    (i32.const 107)
    (i32.const 95)
    (i32.const 107)
    (i32.const 101)
    (i32.const 121)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_check_data (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 20
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 99)
    (i32.const 104)
    (i32.const 101)
    (i32.const 99)
    (i32.const 107)
    (i32.const 95)
    (i32.const 100)
    (i32.const 97)
    (i32.const 116)
    (i32.const 97)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_blit_key (type $C_import_func_VVVVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (param $3 (ref eq)) (param $4 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 18
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 98)
    (i32.const 108)
    (i32.const 105)
    (i32.const 116)
    (i32.const 95)
    (i32.const 107)
    (i32.const 101)
    (i32.const 121)
   )
  )
  (unreachable)
 )
 (func $C_caml_ephe_blit_data (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 19
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 101)
    (i32.const 112)
    (i32.const 104)
    (i32.const 101)
    (i32.const 95)
    (i32.const 98)
    (i32.const 108)
    (i32.const 105)
    (i32.const 116)
    (i32.const 95)
    (i32.const 100)
    (i32.const 97)
    (i32.const 116)
    (i32.const 97)
   )
  )
  (unreachable)
 )
 (func $45 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (ref.i31
   (i32.const 0)
  )
 )
 (func $46 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (ref.i31
   (i32.const 0)
  )
 )
 (func $47 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (ref.i31
   (i32.const 0)
  )
 )
 (func $48 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 17
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 105)
    (i32.const 110)
    (i32.const 116)
    (i32.const 51)
    (i32.const 50)
    (i32.const 95)
    (i32.const 102)
    (i32.const 111)
    (i32.const 114)
    (i32.const 109)
    (i32.const 97)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $49 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 21
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 110)
    (i32.const 97)
    (i32.const 116)
    (i32.const 105)
    (i32.const 118)
    (i32.const 101)
    (i32.const 105)
    (i32.const 110)
    (i32.const 116)
    (i32.const 95)
    (i32.const 102)
    (i32.const 111)
    (i32.const 114)
    (i32.const 109)
    (i32.const 97)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $50 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 17
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 105)
    (i32.const 110)
    (i32.const 116)
    (i32.const 54)
    (i32.const 52)
    (i32.const 95)
    (i32.const 102)
    (i32.const 111)
    (i32.const 114)
    (i32.const 109)
    (i32.const 97)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $51 (type $C_import_func_VVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 23
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 104)
    (i32.const 101)
    (i32.const 120)
    (i32.const 115)
    (i32.const 116)
    (i32.const 114)
    (i32.const 105)
    (i32.const 110)
    (i32.const 103)
    (i32.const 95)
    (i32.const 111)
    (i32.const 102)
    (i32.const 95)
    (i32.const 102)
    (i32.const 108)
    (i32.const 111)
    (i32.const 97)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $52 (type $C_import_func_VV_V) (param $size (ref eq)) (param $value (ref eq)) (result (ref eq))
  (array.new $Array
   (local.get $value)
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $size)
    )
   )
  )
 )
 (func $53 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 19
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 109)
    (i32.const 97)
    (i32.const 107)
    (i32.const 101)
    (i32.const 95)
    (i32.const 102)
    (i32.const 108)
    (i32.const 111)
    (i32.const 97)
    (i32.const 116)
    (i32.const 95)
    (i32.const 118)
    (i32.const 101)
    (i32.const 99)
   )
  )
  (unreachable)
 )
 (func $54 (type $C_import_func_VVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 14
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 97)
    (i32.const 114)
    (i32.const 114)
    (i32.const 97)
    (i32.const 121)
    (i32.const 95)
    (i32.const 115)
    (i32.const 117)
    (i32.const 98)
   )
  )
  (unreachable)
 )
 (func $55 (type $C_import_func_VV_V) (param $0 (ref eq)) (param $1 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 17
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 97)
    (i32.const 114)
    (i32.const 114)
    (i32.const 97)
    (i32.const 121)
    (i32.const 95)
    (i32.const 97)
    (i32.const 112)
    (i32.const 112)
    (i32.const 101)
    (i32.const 110)
    (i32.const 100)
   )
  )
  (unreachable)
 )
 (func $56 (type $C_import_func_V_V) (param $0 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 17
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 97)
    (i32.const 114)
    (i32.const 114)
    (i32.const 97)
    (i32.const 121)
    (i32.const 95)
    (i32.const 99)
    (i32.const 111)
    (i32.const 110)
    (i32.const 99)
    (i32.const 97)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $57 (type $C_import_func_VVVVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (param $3 (ref eq)) (param $4 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 15
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 97)
    (i32.const 114)
    (i32.const 114)
    (i32.const 97)
    (i32.const 121)
    (i32.const 95)
    (i32.const 98)
    (i32.const 108)
    (i32.const 105)
    (i32.const 116)
   )
  )
  (unreachable)
 )
 (func $58 (type $C_import_func_VVVV_V) (param $0 (ref eq)) (param $1 (ref eq)) (param $2 (ref eq)) (param $3 (ref eq)) (result (ref eq))
  (call $print_string_23
   (array.new_fixed $String 15
    (i32.const 99)
    (i32.const 97)
    (i32.const 109)
    (i32.const 108)
    (i32.const 95)
    (i32.const 97)
    (i32.const 114)
    (i32.const 114)
    (i32.const 97)
    (i32.const 121)
    (i32.const 95)
    (i32.const 102)
    (i32.const 105)
    (i32.const 108)
    (i32.const 108)
   )
  )
  (unreachable)
 )
 (func $59 (type $C_import_func_V_V) (param $a (ref eq)) (result (ref eq))
  (call $print_i32
   (i31.get_s
    (ref.cast (ref i31)
     (local.get $a)
    )
   )
  )
  (ref.i31
   (i32.const 0)
  )
 )
 (func $60 (type $C_import_func_V_V) (param $a (ref eq)) (result (ref eq))
  (call $print_f64
   (struct.get $Float 0
    (ref.cast (ref $Float)
     (local.get $a)
    )
   )
  )
  (ref.i31
   (i32.const 0)
  )
 )
 (func $61 (type $C_import_func_V_V) (param $a (ref eq)) (result (ref eq))
  (call $print_endline)
  (ref.i31
   (i32.const 0)
  )
 )
 (func $Caml_curry_2_1 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Gen_closure_2))
  (local $Partial_closure (ref $Partial_closure_2_1))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Partial_closure
     (ref.cast (ref $Partial_closure_2_1)
      (local.get $Env)
     )
    )
    (local.set $Closure
     (struct.get $Partial_closure_2_1 2
      (local.get $Partial_closure)
     )
    )
    (return_call_ref $Func_2
     (struct.get $Partial_closure_2_1 3
      (local.get $Partial_closure)
     )
     (local.get $P_arg_0)
     (local.get $Closure)
     (struct.get $Gen_closure_2 2
      (local.get $Closure)
     )
    )
   )
  )
 )
 (func $Caml_curry_2 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_2_1)))
    (struct.new $Partial_closure_2_1
     (i32.const 1)
     (ref.func $Caml_curry_2_1)
     (ref.cast (ref $Gen_closure_2)
      (local.get $Env)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $R_not_really_start (type $22)
 )
 (func $Start (type $22)
  (call $R_not_really_start)
 )
 (func $erase_rel_11 (type $Func_1) (param $P_param_13 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $switch_result#113 (ref eq))
  (local $call_result2#112 (ref eq))
  (local $call_result2#110 (ref eq))
  (local $call_result2#108 (ref eq))
  (local $call_result2#106 (ref eq))
  (local $call_result2#104 (ref eq))
  (local $call_result2#102 (ref eq))
  (local $call_result2#100 (ref eq))
  (local $call_result2#98 (ref eq))
  (local $call_result2#96 (ref eq))
  (local $call_result2#94 (ref eq))
  (local $call_result2#92 (ref eq))
  (local $call_result2#90 (ref eq))
  (local $call_result2#88 (ref eq))
  (local $call_result2#86 (ref eq))
  (local $call_result2#84 (ref eq))
  (local $call_result1#111 i32)
  (local $call_result1#109 i32)
  (local $call_result1#107 i32)
  (local $call_result1#105 i32)
  (local $call_result1#103 i32)
  (local $call_result1#101 i32)
  (local $call_result1#99 i32)
  (local $call_result1#97 i32)
  (local $call_result1#95 i32)
  (local $call_result1#93 i32)
  (local $call_result1#91 i32)
  (local $call_result1#89 i32)
  (local $call_result1#87 i32)
  (local $call_result1#85 i32)
  (local $call_result1#83 i32)
  (local $ty1_63 (ref eq))
  (local $apply_funct_92 (ref eq))
  (local $apply_funct_87 (ref eq))
  (local $apply_funct_82 (ref eq))
  (local $apply_funct_77 (ref eq))
  (local $apply_funct_72 (ref eq))
  (local $apply_funct_67 (ref eq))
  (local $apply_funct_59 (ref eq))
  (local $apply_funct_53 (ref eq))
  (local $apply_funct_48 (ref eq))
  (local $apply_funct_43 (ref eq))
  (local $apply_funct_38 (ref eq))
  (local $apply_funct_33 (ref eq))
  (local $apply_funct_28 (ref eq))
  (local $apply_funct_23 (ref eq))
  (local $apply_funct_18 (ref eq))
  (local $apply_arg_91 (ref eq))
  (local $apply_arg_86 (ref eq))
  (local $apply_arg_81 (ref eq))
  (local $apply_arg_76 (ref eq))
  (local $apply_arg_71 (ref eq))
  (local $apply_arg_66 (ref eq))
  (local $apply_arg_58 (ref eq))
  (local $apply_arg_52 (ref eq))
  (local $apply_arg_47 (ref eq))
  (local $apply_arg_42 (ref eq))
  (local $apply_arg_37 (ref eq))
  (local $apply_arg_32 (ref eq))
  (local $apply_arg_27 (ref eq))
  (local $apply_arg_22 (ref eq))
  (local $apply_arg_17 (ref eq))
  (local $Pmakeblock_arg_93 (ref eq))
  (local $Pmakeblock_arg_88 (ref eq))
  (local $Pmakeblock_arg_83 (ref eq))
  (local $Pmakeblock_arg_78 (ref eq))
  (local $Pmakeblock_arg_73 (ref eq))
  (local $Pmakeblock_arg_68 (ref eq))
  (local $Pmakeblock_arg_61 (ref eq))
  (local $Pmakeblock_arg_60 (ref eq))
  (local $Pmakeblock_arg_54 (ref eq))
  (local $Pmakeblock_arg_49 (ref eq))
  (local $Pmakeblock_arg_44 (ref eq))
  (local $Pmakeblock_arg_39 (ref eq))
  (local $Pmakeblock_arg_34 (ref eq))
  (local $Pmakeblock_arg_29 (ref eq))
  (local $Pmakeblock_arg_24 (ref eq))
  (local $Pmakeblock_arg_19 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_81 i32)
  (local $scratch_82 (tuple i32 (ref eq)))
  (local $scratch_83 i32)
  (local $scratch_84 (tuple i32 (ref eq)))
  (local $scratch_85 i32)
  (local $scratch_86 (tuple i32 (ref eq)))
  (local $scratch_87 i32)
  (local $scratch_88 (tuple i32 (ref eq)))
  (local $scratch_89 i32)
  (local $scratch_90 (tuple i32 (ref eq)))
  (local $scratch_91 i32)
  (local $scratch_92 (tuple i32 (ref eq)))
  (local $scratch_93 i32)
  (local $scratch_94 (tuple i32 (ref eq)))
  (local $scratch_95 i32)
  (local $scratch_96 (tuple i32 (ref eq)))
  (local $scratch_97 i32)
  (local $scratch_98 (tuple i32 (ref eq)))
  (local $scratch_99 i32)
  (local $scratch_100 (tuple i32 (ref eq)))
  (local $scratch_101 i32)
  (local $scratch_102 (tuple i32 (ref eq)))
  (local $scratch_103 i32)
  (local $scratch_104 (tuple i32 (ref eq)))
  (local $scratch_105 i32)
  (local $scratch_106 (tuple i32 (ref eq)))
  (local $scratch_107 i32)
  (local $scratch_108 (tuple i32 (ref eq)))
  (local $scratch_109 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (block $!switch_result_64 (result (ref eq))
     (local.set $switch_result#113
      (block $switch_result_64 (result (ref eq))
       (block
        (block $switch_0_49
         (block $switch_1_50
          (block $switch_2_51
           (block $switch_3_52
            (block $switch_4_53
             (block $switch_5_54
              (block $switch_6_55
               (block $switch_7_56
                (block $switch_8_57
                 (block $switch_9_58
                  (block $switch_10_59
                   (block $switch_11_60
                    (block $switch_12_61
                     (block $switch_13_62
                      (block $switch_14_63
                       (block $switch_0_48
                        (if
                         (ref.test (ref i31)
                          (local.get $P_param_13)
                         )
                         (then
                          (br_table $switch_0_48 $switch_0_48
                           (i31.get_s
                            (ref.cast (ref i31)
                             (local.get $P_param_13)
                            )
                           )
                          )
                         )
                         (else
                          (br_table $switch_0_49 $switch_1_50 $switch_2_51 $switch_3_52 $switch_4_53 $switch_5_54 $switch_6_55 $switch_7_56 $switch_8_57 $switch_9_58 $switch_10_59 $switch_11_60 $switch_12_61 $switch_13_62 $switch_14_63 $switch_14_63
                           (i31.get_s
                            (ref.cast (ref i31)
                             (array.get $Array
                              (ref.cast (ref $Array)
                               (local.get $P_param_13)
                              )
                              (i32.const 0)
                             )
                            )
                           )
                          )
                         )
                        )
                       )
                       (br $switch_result_64
                        (ref.i31
                         (i32.const 0)
                        )
                       )
                      )
                      (br $switch_result_64
                       (block (result (ref (exact $Array)))
                        (local.set $apply_arg_91
                         (array.get $Array
                          (ref.cast (ref $Array)
                           (local.get $P_param_13)
                          )
                          (i32.const 1)
                         )
                        )
                        (local.set $apply_funct_92
                         (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
                        )
                        (local.set $Pmakeblock_arg_93
                         (block (result (ref eq))
                          (local.set $call_result1#83
                           (block (result i32)
                            (local.set $scratch_81
                             (tuple.extract 2 0
                              (local.tee $scratch
                               (call $erase_rel_11
                                (local.get $apply_arg_91)
                                (ref.cast (ref $Env)
                                 (local.get $apply_funct_92)
                                )
                               )
                              )
                             )
                            )
                            (local.set $call_result2#84
                             (tuple.extract 2 1
                              (local.get $scratch)
                             )
                            )
                            (local.get $scratch_81)
                           )
                          )
                          (if (result (ref eq))
                           (local.get $call_result1#83)
                           (then
                            (return
                             (tuple.make 2
                              (i32.const 1)
                              (local.get $call_result2#84)
                             )
                            )
                           )
                           (else
                            (local.get $call_result2#84)
                           )
                          )
                         )
                        )
                        (array.new_fixed $Array 2
                         (ref.i31
                          (i32.const 14)
                         )
                         (local.get $Pmakeblock_arg_93)
                        )
                       )
                      )
                     )
                     (br $switch_result_64
                      (block (result (ref (exact $Array)))
                       (local.set $apply_arg_86
                        (array.get $Array
                         (ref.cast (ref $Array)
                          (local.get $P_param_13)
                         )
                         (i32.const 1)
                        )
                       )
                       (local.set $apply_funct_87
                        (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
                       )
                       (local.set $Pmakeblock_arg_88
                        (block (result (ref eq))
                         (local.set $call_result1#85
                          (block (result i32)
                           (local.set $scratch_83
                            (tuple.extract 2 0
                             (local.tee $scratch_82
                              (call $erase_rel_11
                               (local.get $apply_arg_86)
                               (ref.cast (ref $Env)
                                (local.get $apply_funct_87)
                               )
                              )
                             )
                            )
                           )
                           (local.set $call_result2#86
                            (tuple.extract 2 1
                             (local.get $scratch_82)
                            )
                           )
                           (local.get $scratch_83)
                          )
                         )
                         (if (result (ref eq))
                          (local.get $call_result1#85)
                          (then
                           (return
                            (tuple.make 2
                             (i32.const 1)
                             (local.get $call_result2#86)
                            )
                           )
                          )
                          (else
                           (local.get $call_result2#86)
                          )
                         )
                        )
                       )
                       (array.new_fixed $Array 2
                        (ref.i31
                         (i32.const 13)
                        )
                        (local.get $Pmakeblock_arg_88)
                       )
                      )
                     )
                    )
                    (br $switch_result_64
                     (block (result (ref (exact $Array)))
                      (local.set $apply_arg_81
                       (array.get $Array
                        (ref.cast (ref $Array)
                         (local.get $P_param_13)
                        )
                        (i32.const 1)
                       )
                      )
                      (local.set $apply_funct_82
                       (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
                      )
                      (local.set $Pmakeblock_arg_83
                       (block (result (ref eq))
                        (local.set $call_result1#87
                         (block (result i32)
                          (local.set $scratch_85
                           (tuple.extract 2 0
                            (local.tee $scratch_84
                             (call $erase_rel_11
                              (local.get $apply_arg_81)
                              (ref.cast (ref $Env)
                               (local.get $apply_funct_82)
                              )
                             )
                            )
                           )
                          )
                          (local.set $call_result2#88
                           (tuple.extract 2 1
                            (local.get $scratch_84)
                           )
                          )
                          (local.get $scratch_85)
                         )
                        )
                        (if (result (ref eq))
                         (local.get $call_result1#87)
                         (then
                          (return
                           (tuple.make 2
                            (i32.const 1)
                            (local.get $call_result2#88)
                           )
                          )
                         )
                         (else
                          (local.get $call_result2#88)
                         )
                        )
                       )
                      )
                      (array.new_fixed $Array 2
                       (ref.i31
                        (i32.const 12)
                       )
                       (local.get $Pmakeblock_arg_83)
                      )
                     )
                    )
                   )
                   (br $switch_result_64
                    (block (result (ref (exact $Array)))
                     (local.set $apply_arg_76
                      (array.get $Array
                       (ref.cast (ref $Array)
                        (local.get $P_param_13)
                       )
                       (i32.const 1)
                      )
                     )
                     (local.set $apply_funct_77
                      (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
                     )
                     (local.set $Pmakeblock_arg_78
                      (block (result (ref eq))
                       (local.set $call_result1#89
                        (block (result i32)
                         (local.set $scratch_87
                          (tuple.extract 2 0
                           (local.tee $scratch_86
                            (call $erase_rel_11
                             (local.get $apply_arg_76)
                             (ref.cast (ref $Env)
                              (local.get $apply_funct_77)
                             )
                            )
                           )
                          )
                         )
                         (local.set $call_result2#90
                          (tuple.extract 2 1
                           (local.get $scratch_86)
                          )
                         )
                         (local.get $scratch_87)
                        )
                       )
                       (if (result (ref eq))
                        (local.get $call_result1#89)
                        (then
                         (return
                          (tuple.make 2
                           (i32.const 1)
                           (local.get $call_result2#90)
                          )
                         )
                        )
                        (else
                         (local.get $call_result2#90)
                        )
                       )
                      )
                     )
                     (array.new_fixed $Array 2
                      (ref.i31
                       (i32.const 11)
                      )
                      (local.get $Pmakeblock_arg_78)
                     )
                    )
                   )
                  )
                  (br $switch_result_64
                   (block (result (ref (exact $Array)))
                    (local.set $apply_arg_71
                     (array.get $Array
                      (ref.cast (ref $Array)
                       (local.get $P_param_13)
                      )
                      (i32.const 1)
                     )
                    )
                    (local.set $apply_funct_72
                     (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
                    )
                    (local.set $Pmakeblock_arg_73
                     (block (result (ref eq))
                      (local.set $call_result1#91
                       (block (result i32)
                        (local.set $scratch_89
                         (tuple.extract 2 0
                          (local.tee $scratch_88
                           (call $erase_rel_11
                            (local.get $apply_arg_71)
                            (ref.cast (ref $Env)
                             (local.get $apply_funct_72)
                            )
                           )
                          )
                         )
                        )
                        (local.set $call_result2#92
                         (tuple.extract 2 1
                          (local.get $scratch_88)
                         )
                        )
                        (local.get $scratch_89)
                       )
                      )
                      (if (result (ref eq))
                       (local.get $call_result1#91)
                       (then
                        (return
                         (tuple.make 2
                          (i32.const 1)
                          (local.get $call_result2#92)
                         )
                        )
                       )
                       (else
                        (local.get $call_result2#92)
                       )
                      )
                     )
                    )
                    (array.new_fixed $Array 2
                     (ref.i31
                      (i32.const 10)
                     )
                     (local.get $Pmakeblock_arg_73)
                    )
                   )
                  )
                 )
                 (br $switch_result_64
                  (block (result (ref (exact $Array)))
                   (local.set $ty1_63
                    (array.get $Array
                     (ref.cast (ref $Array)
                      (local.get $P_param_13)
                     )
                     (i32.const 1)
                    )
                   )
                   (local.set $apply_arg_66
                    (array.get $Array
                     (ref.cast (ref $Array)
                      (local.get $P_param_13)
                     )
                     (i32.const 3)
                    )
                   )
                   (local.set $apply_funct_67
                    (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
                   )
                   (local.set $Pmakeblock_arg_68
                    (block (result (ref eq))
                     (local.set $call_result1#93
                      (block (result i32)
                       (local.set $scratch_91
                        (tuple.extract 2 0
                         (local.tee $scratch_90
                          (call $erase_rel_11
                           (local.get $apply_arg_66)
                           (ref.cast (ref $Env)
                            (local.get $apply_funct_67)
                           )
                          )
                         )
                        )
                       )
                       (local.set $call_result2#94
                        (tuple.extract 2 1
                         (local.get $scratch_90)
                        )
                       )
                       (local.get $scratch_91)
                      )
                     )
                     (if (result (ref eq))
                      (local.get $call_result1#93)
                      (then
                       (return
                        (tuple.make 2
                         (i32.const 1)
                         (local.get $call_result2#94)
                        )
                       )
                      )
                      (else
                       (local.get $call_result2#94)
                      )
                     )
                    )
                   )
                   (array.new_fixed $Array 4
                    (ref.i31
                     (i32.const 9)
                    )
                    (local.get $ty1_63)
                    (local.get $ty1_63)
                    (local.get $Pmakeblock_arg_68)
                   )
                  )
                 )
                )
                (br $switch_result_64
                 (block (result (ref (exact $Array)))
                  (local.set $apply_arg_58
                   (array.get $Array
                    (ref.cast (ref $Array)
                     (local.get $P_param_13)
                    )
                    (i32.const 2)
                   )
                  )
                  (local.set $apply_funct_59
                   (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
                  )
                  (local.set $Pmakeblock_arg_60
                   (block (result (ref eq))
                    (local.set $call_result1#95
                     (block (result i32)
                      (local.set $scratch_93
                       (tuple.extract 2 0
                        (local.tee $scratch_92
                         (call $erase_rel_11
                          (local.get $apply_arg_58)
                          (ref.cast (ref $Env)
                           (local.get $apply_funct_59)
                          )
                         )
                        )
                       )
                      )
                      (local.set $call_result2#96
                       (tuple.extract 2 1
                        (local.get $scratch_92)
                       )
                      )
                      (local.get $scratch_93)
                     )
                    )
                    (if (result (ref eq))
                     (local.get $call_result1#95)
                     (then
                      (return
                       (tuple.make 2
                        (i32.const 1)
                        (local.get $call_result2#96)
                       )
                      )
                     )
                     (else
                      (local.get $call_result2#96)
                     )
                    )
                   )
                  )
                  (local.set $Pmakeblock_arg_61
                   (array.get $Array
                    (ref.cast (ref $Array)
                     (local.get $P_param_13)
                    )
                    (i32.const 1)
                   )
                  )
                  (array.new_fixed $Array 3
                   (ref.i31
                    (i32.const 8)
                   )
                   (local.get $Pmakeblock_arg_61)
                   (local.get $Pmakeblock_arg_60)
                  )
                 )
                )
               )
               (br $switch_result_64
                (block (result (ref (exact $Array)))
                 (local.set $apply_arg_52
                  (array.get $Array
                   (ref.cast (ref $Array)
                    (local.get $P_param_13)
                   )
                   (i32.const 1)
                  )
                 )
                 (local.set $apply_funct_53
                  (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
                 )
                 (local.set $Pmakeblock_arg_54
                  (block (result (ref eq))
                   (local.set $call_result1#97
                    (block (result i32)
                     (local.set $scratch_95
                      (tuple.extract 2 0
                       (local.tee $scratch_94
                        (call $erase_rel_11
                         (local.get $apply_arg_52)
                         (ref.cast (ref $Env)
                          (local.get $apply_funct_53)
                         )
                        )
                       )
                      )
                     )
                     (local.set $call_result2#98
                      (tuple.extract 2 1
                       (local.get $scratch_94)
                      )
                     )
                     (local.get $scratch_95)
                    )
                   )
                   (if (result (ref eq))
                    (local.get $call_result1#97)
                    (then
                     (return
                      (tuple.make 2
                       (i32.const 1)
                       (local.get $call_result2#98)
                      )
                     )
                    )
                    (else
                     (local.get $call_result2#98)
                    )
                   )
                  )
                 )
                 (array.new_fixed $Array 2
                  (ref.i31
                   (i32.const 7)
                  )
                  (local.get $Pmakeblock_arg_54)
                 )
                )
               )
              )
              (br $switch_result_64
               (block (result (ref (exact $Array)))
                (local.set $apply_arg_47
                 (array.get $Array
                  (ref.cast (ref $Array)
                   (local.get $P_param_13)
                  )
                  (i32.const 1)
                 )
                )
                (local.set $apply_funct_48
                 (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
                )
                (local.set $Pmakeblock_arg_49
                 (block (result (ref eq))
                  (local.set $call_result1#99
                   (block (result i32)
                    (local.set $scratch_97
                     (tuple.extract 2 0
                      (local.tee $scratch_96
                       (call $erase_rel_11
                        (local.get $apply_arg_47)
                        (ref.cast (ref $Env)
                         (local.get $apply_funct_48)
                        )
                       )
                      )
                     )
                    )
                    (local.set $call_result2#100
                     (tuple.extract 2 1
                      (local.get $scratch_96)
                     )
                    )
                    (local.get $scratch_97)
                   )
                  )
                  (if (result (ref eq))
                   (local.get $call_result1#99)
                   (then
                    (return
                     (tuple.make 2
                      (i32.const 1)
                      (local.get $call_result2#100)
                     )
                    )
                   )
                   (else
                    (local.get $call_result2#100)
                   )
                  )
                 )
                )
                (array.new_fixed $Array 2
                 (ref.i31
                  (i32.const 6)
                 )
                 (local.get $Pmakeblock_arg_49)
                )
               )
              )
             )
             (br $switch_result_64
              (block (result (ref (exact $Array)))
               (local.set $apply_arg_42
                (array.get $Array
                 (ref.cast (ref $Array)
                  (local.get $P_param_13)
                 )
                 (i32.const 1)
                )
               )
               (local.set $apply_funct_43
                (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
               )
               (local.set $Pmakeblock_arg_44
                (block (result (ref eq))
                 (local.set $call_result1#101
                  (block (result i32)
                   (local.set $scratch_99
                    (tuple.extract 2 0
                     (local.tee $scratch_98
                      (call $erase_rel_11
                       (local.get $apply_arg_42)
                       (ref.cast (ref $Env)
                        (local.get $apply_funct_43)
                       )
                      )
                     )
                    )
                   )
                   (local.set $call_result2#102
                    (tuple.extract 2 1
                     (local.get $scratch_98)
                    )
                   )
                   (local.get $scratch_99)
                  )
                 )
                 (if (result (ref eq))
                  (local.get $call_result1#101)
                  (then
                   (return
                    (tuple.make 2
                     (i32.const 1)
                     (local.get $call_result2#102)
                    )
                   )
                  )
                  (else
                   (local.get $call_result2#102)
                  )
                 )
                )
               )
               (array.new_fixed $Array 2
                (ref.i31
                 (i32.const 5)
                )
                (local.get $Pmakeblock_arg_44)
               )
              )
             )
            )
            (br $switch_result_64
             (block (result (ref (exact $Array)))
              (local.set $apply_arg_37
               (array.get $Array
                (ref.cast (ref $Array)
                 (local.get $P_param_13)
                )
                (i32.const 1)
               )
              )
              (local.set $apply_funct_38
               (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
              )
              (local.set $Pmakeblock_arg_39
               (block (result (ref eq))
                (local.set $call_result1#103
                 (block (result i32)
                  (local.set $scratch_101
                   (tuple.extract 2 0
                    (local.tee $scratch_100
                     (call $erase_rel_11
                      (local.get $apply_arg_37)
                      (ref.cast (ref $Env)
                       (local.get $apply_funct_38)
                      )
                     )
                    )
                   )
                  )
                  (local.set $call_result2#104
                   (tuple.extract 2 1
                    (local.get $scratch_100)
                   )
                  )
                  (local.get $scratch_101)
                 )
                )
                (if (result (ref eq))
                 (local.get $call_result1#103)
                 (then
                  (return
                   (tuple.make 2
                    (i32.const 1)
                    (local.get $call_result2#104)
                   )
                  )
                 )
                 (else
                  (local.get $call_result2#104)
                 )
                )
               )
              )
              (array.new_fixed $Array 2
               (ref.i31
                (i32.const 4)
               )
               (local.get $Pmakeblock_arg_39)
              )
             )
            )
           )
           (br $switch_result_64
            (block (result (ref (exact $Array)))
             (local.set $apply_arg_32
              (array.get $Array
               (ref.cast (ref $Array)
                (local.get $P_param_13)
               )
               (i32.const 1)
              )
             )
             (local.set $apply_funct_33
              (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
             )
             (local.set $Pmakeblock_arg_34
              (block (result (ref eq))
               (local.set $call_result1#105
                (block (result i32)
                 (local.set $scratch_103
                  (tuple.extract 2 0
                   (local.tee $scratch_102
                    (call $erase_rel_11
                     (local.get $apply_arg_32)
                     (ref.cast (ref $Env)
                      (local.get $apply_funct_33)
                     )
                    )
                   )
                  )
                 )
                 (local.set $call_result2#106
                  (tuple.extract 2 1
                   (local.get $scratch_102)
                  )
                 )
                 (local.get $scratch_103)
                )
               )
               (if (result (ref eq))
                (local.get $call_result1#105)
                (then
                 (return
                  (tuple.make 2
                   (i32.const 1)
                   (local.get $call_result2#106)
                  )
                 )
                )
                (else
                 (local.get $call_result2#106)
                )
               )
              )
             )
             (array.new_fixed $Array 2
              (ref.i31
               (i32.const 3)
              )
              (local.get $Pmakeblock_arg_34)
             )
            )
           )
          )
          (br $switch_result_64
           (block (result (ref (exact $Array)))
            (local.set $apply_arg_27
             (array.get $Array
              (ref.cast (ref $Array)
               (local.get $P_param_13)
              )
              (i32.const 1)
             )
            )
            (local.set $apply_funct_28
             (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
            )
            (local.set $Pmakeblock_arg_29
             (block (result (ref eq))
              (local.set $call_result1#107
               (block (result i32)
                (local.set $scratch_105
                 (tuple.extract 2 0
                  (local.tee $scratch_104
                   (call $erase_rel_11
                    (local.get $apply_arg_27)
                    (ref.cast (ref $Env)
                     (local.get $apply_funct_28)
                    )
                   )
                  )
                 )
                )
                (local.set $call_result2#108
                 (tuple.extract 2 1
                  (local.get $scratch_104)
                 )
                )
                (local.get $scratch_105)
               )
              )
              (if (result (ref eq))
               (local.get $call_result1#107)
               (then
                (return
                 (tuple.make 2
                  (i32.const 1)
                  (local.get $call_result2#108)
                 )
                )
               )
               (else
                (local.get $call_result2#108)
               )
              )
             )
            )
            (array.new_fixed $Array 2
             (ref.i31
              (i32.const 2)
             )
             (local.get $Pmakeblock_arg_29)
            )
           )
          )
         )
         (br $switch_result_64
          (block (result (ref (exact $Array)))
           (local.set $apply_arg_22
            (array.get $Array
             (ref.cast (ref $Array)
              (local.get $P_param_13)
             )
             (i32.const 1)
            )
           )
           (local.set $apply_funct_23
            (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
           )
           (local.set $Pmakeblock_arg_24
            (block (result (ref eq))
             (local.set $call_result1#109
              (block (result i32)
               (local.set $scratch_107
                (tuple.extract 2 0
                 (local.tee $scratch_106
                  (call $erase_rel_11
                   (local.get $apply_arg_22)
                   (ref.cast (ref $Env)
                    (local.get $apply_funct_23)
                   )
                  )
                 )
                )
               )
               (local.set $call_result2#110
                (tuple.extract 2 1
                 (local.get $scratch_106)
                )
               )
               (local.get $scratch_107)
              )
             )
             (if (result (ref eq))
              (local.get $call_result1#109)
              (then
               (return
                (tuple.make 2
                 (i32.const 1)
                 (local.get $call_result2#110)
                )
               )
              )
              (else
               (local.get $call_result2#110)
              )
             )
            )
           )
           (array.new_fixed $Array 2
            (ref.i31
             (i32.const 1)
            )
            (local.get $Pmakeblock_arg_24)
           )
          )
         )
        )
        (br $switch_result_64
         (block (result (ref (exact $Array)))
          (local.set $apply_arg_17
           (array.get $Array
            (ref.cast (ref $Array)
             (local.get $P_param_13)
            )
            (i32.const 1)
           )
          )
          (local.set $apply_funct_18
           (global.get $camlCamlinternalFormatBasics__erase_rel_11_closure)
          )
          (local.set $Pmakeblock_arg_19
           (block (result (ref eq))
            (local.set $call_result1#111
             (block (result i32)
              (local.set $scratch_109
               (tuple.extract 2 0
                (local.tee $scratch_108
                 (call $erase_rel_11
                  (local.get $apply_arg_17)
                  (ref.cast (ref $Env)
                   (local.get $apply_funct_18)
                  )
                 )
                )
               )
              )
              (local.set $call_result2#112
               (tuple.extract 2 1
                (local.get $scratch_108)
               )
              )
              (local.get $scratch_109)
             )
            )
            (if (result (ref eq))
             (local.get $call_result1#111)
             (then
              (return
               (tuple.make 2
                (i32.const 1)
                (local.get $call_result2#112)
               )
              )
             )
             (else
              (local.get $call_result2#112)
             )
            )
           )
          )
          (array.new_fixed $Array 2
           (ref.i31
            (i32.const 0)
           )
           (local.get $Pmakeblock_arg_19)
          )
         )
        )
       )
      )
     )
     (local.get $switch_result#113)
    )
   )
  )
 )
 (func $concat_fmtty_97 (type $Func_2) (param $P_fmtty1_100 (ref eq)) (param $P_fmtty2_99 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $switch_result#82 (ref eq))
  (local $call_result2#81 (ref eq))
  (local $call_result2#79 (ref eq))
  (local $call_result2#77 (ref eq))
  (local $call_result2#75 (ref eq))
  (local $call_result2#73 (ref eq))
  (local $call_result2#71 (ref eq))
  (local $call_result2#69 (ref eq))
  (local $call_result2#67 (ref eq))
  (local $call_result2#65 (ref eq))
  (local $call_result2#63 (ref eq))
  (local $call_result2#61 (ref eq))
  (local $call_result2#59 (ref eq))
  (local $call_result2#57 (ref eq))
  (local $call_result2#55 (ref eq))
  (local $call_result2#53 (ref eq))
  (local $call_result1#80 i32)
  (local $call_result1#78 i32)
  (local $call_result1#76 i32)
  (local $call_result1#74 i32)
  (local $call_result1#72 i32)
  (local $call_result1#70 i32)
  (local $call_result1#68 i32)
  (local $call_result1#66 i32)
  (local $call_result1#64 i32)
  (local $call_result1#62 i32)
  (local $call_result1#60 i32)
  (local $call_result1#58 i32)
  (local $call_result1#56 i32)
  (local $call_result1#54 i32)
  (local $call_result1#52 i32)
  (local $apply_funct_181 (ref eq))
  (local $apply_funct_176 (ref eq))
  (local $apply_funct_171 (ref eq))
  (local $apply_funct_166 (ref eq))
  (local $apply_funct_161 (ref eq))
  (local $apply_funct_154 (ref eq))
  (local $apply_funct_146 (ref eq))
  (local $apply_funct_140 (ref eq))
  (local $apply_funct_135 (ref eq))
  (local $apply_funct_130 (ref eq))
  (local $apply_funct_125 (ref eq))
  (local $apply_funct_120 (ref eq))
  (local $apply_funct_115 (ref eq))
  (local $apply_funct_110 (ref eq))
  (local $apply_funct_105 (ref eq))
  (local $apply_arg_180 (ref eq))
  (local $apply_arg_175 (ref eq))
  (local $apply_arg_170 (ref eq))
  (local $apply_arg_165 (ref eq))
  (local $apply_arg_160 (ref eq))
  (local $apply_arg_153 (ref eq))
  (local $apply_arg_145 (ref eq))
  (local $apply_arg_139 (ref eq))
  (local $apply_arg_134 (ref eq))
  (local $apply_arg_129 (ref eq))
  (local $apply_arg_124 (ref eq))
  (local $apply_arg_119 (ref eq))
  (local $apply_arg_114 (ref eq))
  (local $apply_arg_109 (ref eq))
  (local $apply_arg_104 (ref eq))
  (local $Pmakeblock_arg_182 (ref eq))
  (local $Pmakeblock_arg_177 (ref eq))
  (local $Pmakeblock_arg_172 (ref eq))
  (local $Pmakeblock_arg_167 (ref eq))
  (local $Pmakeblock_arg_162 (ref eq))
  (local $Pmakeblock_arg_157 (ref eq))
  (local $Pmakeblock_arg_156 (ref eq))
  (local $Pmakeblock_arg_155 (ref eq))
  (local $Pmakeblock_arg_148 (ref eq))
  (local $Pmakeblock_arg_147 (ref eq))
  (local $Pmakeblock_arg_141 (ref eq))
  (local $Pmakeblock_arg_136 (ref eq))
  (local $Pmakeblock_arg_131 (ref eq))
  (local $Pmakeblock_arg_126 (ref eq))
  (local $Pmakeblock_arg_121 (ref eq))
  (local $Pmakeblock_arg_116 (ref eq))
  (local $Pmakeblock_arg_111 (ref eq))
  (local $Pmakeblock_arg_106 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_83 i32)
  (local $scratch_84 (tuple i32 (ref eq)))
  (local $scratch_85 i32)
  (local $scratch_86 (tuple i32 (ref eq)))
  (local $scratch_87 i32)
  (local $scratch_88 (tuple i32 (ref eq)))
  (local $scratch_89 i32)
  (local $scratch_90 (tuple i32 (ref eq)))
  (local $scratch_91 i32)
  (local $scratch_92 (tuple i32 (ref eq)))
  (local $scratch_93 i32)
  (local $scratch_94 (tuple i32 (ref eq)))
  (local $scratch_95 i32)
  (local $scratch_96 (tuple i32 (ref eq)))
  (local $scratch_97 i32)
  (local $scratch_98 (tuple i32 (ref eq)))
  (local $scratch_99 i32)
  (local $scratch_100 (tuple i32 (ref eq)))
  (local $scratch_101 i32)
  (local $scratch_102 (tuple i32 (ref eq)))
  (local $scratch_103 i32)
  (local $scratch_104 (tuple i32 (ref eq)))
  (local $scratch_105 i32)
  (local $scratch_106 (tuple i32 (ref eq)))
  (local $scratch_107 i32)
  (local $scratch_108 (tuple i32 (ref eq)))
  (local $scratch_109 i32)
  (local $scratch_110 (tuple i32 (ref eq)))
  (local $scratch_111 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (block $!switch_result_46 (result (ref eq))
     (local.set $switch_result#82
      (block $switch_result_46 (result (ref eq))
       (block
        (block $switch_0_31
         (block $switch_1_32
          (block $switch_2_33
           (block $switch_3_34
            (block $switch_4_35
             (block $switch_5_36
              (block $switch_6_37
               (block $switch_7_38
                (block $switch_8_39
                 (block $switch_9_40
                  (block $switch_10_41
                   (block $switch_11_42
                    (block $switch_12_43
                     (block $switch_13_44
                      (block $switch_14_45
                       (block $switch_0_30
                        (if
                         (ref.test (ref i31)
                          (local.get $P_fmtty1_100)
                         )
                         (then
                          (br_table $switch_0_30 $switch_0_30
                           (i31.get_s
                            (ref.cast (ref i31)
                             (local.get $P_fmtty1_100)
                            )
                           )
                          )
                         )
                         (else
                          (br_table $switch_0_31 $switch_1_32 $switch_2_33 $switch_3_34 $switch_4_35 $switch_5_36 $switch_6_37 $switch_7_38 $switch_8_39 $switch_9_40 $switch_10_41 $switch_11_42 $switch_12_43 $switch_13_44 $switch_14_45 $switch_14_45
                           (i31.get_s
                            (ref.cast (ref i31)
                             (array.get $Array
                              (ref.cast (ref $Array)
                               (local.get $P_fmtty1_100)
                              )
                              (i32.const 0)
                             )
                            )
                           )
                          )
                         )
                        )
                       )
                       (br $switch_result_46
                        (local.get $P_fmtty2_99)
                       )
                      )
                      (br $switch_result_46
                       (block (result (ref (exact $Array)))
                        (local.set $apply_arg_180
                         (array.get $Array
                          (ref.cast (ref $Array)
                           (local.get $P_fmtty1_100)
                          )
                          (i32.const 1)
                         )
                        )
                        (local.set $apply_funct_181
                         (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
                        )
                        (local.set $Pmakeblock_arg_182
                         (block (result (ref eq))
                          (local.set $call_result1#52
                           (block (result i32)
                            (local.set $scratch_83
                             (tuple.extract 2 0
                              (local.tee $scratch
                               (call $concat_fmtty_97
                                (local.get $apply_arg_180)
                                (local.get $P_fmtty2_99)
                                (ref.cast (ref $Env)
                                 (local.get $apply_funct_181)
                                )
                               )
                              )
                             )
                            )
                            (local.set $call_result2#53
                             (tuple.extract 2 1
                              (local.get $scratch)
                             )
                            )
                            (local.get $scratch_83)
                           )
                          )
                          (if (result (ref eq))
                           (local.get $call_result1#52)
                           (then
                            (return
                             (tuple.make 2
                              (i32.const 1)
                              (local.get $call_result2#53)
                             )
                            )
                           )
                           (else
                            (local.get $call_result2#53)
                           )
                          )
                         )
                        )
                        (array.new_fixed $Array 2
                         (ref.i31
                          (i32.const 14)
                         )
                         (local.get $Pmakeblock_arg_182)
                        )
                       )
                      )
                     )
                     (br $switch_result_46
                      (block (result (ref (exact $Array)))
                       (local.set $apply_arg_175
                        (array.get $Array
                         (ref.cast (ref $Array)
                          (local.get $P_fmtty1_100)
                         )
                         (i32.const 1)
                        )
                       )
                       (local.set $apply_funct_176
                        (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
                       )
                       (local.set $Pmakeblock_arg_177
                        (block (result (ref eq))
                         (local.set $call_result1#54
                          (block (result i32)
                           (local.set $scratch_85
                            (tuple.extract 2 0
                             (local.tee $scratch_84
                              (call $concat_fmtty_97
                               (local.get $apply_arg_175)
                               (local.get $P_fmtty2_99)
                               (ref.cast (ref $Env)
                                (local.get $apply_funct_176)
                               )
                              )
                             )
                            )
                           )
                           (local.set $call_result2#55
                            (tuple.extract 2 1
                             (local.get $scratch_84)
                            )
                           )
                           (local.get $scratch_85)
                          )
                         )
                         (if (result (ref eq))
                          (local.get $call_result1#54)
                          (then
                           (return
                            (tuple.make 2
                             (i32.const 1)
                             (local.get $call_result2#55)
                            )
                           )
                          )
                          (else
                           (local.get $call_result2#55)
                          )
                         )
                        )
                       )
                       (array.new_fixed $Array 2
                        (ref.i31
                         (i32.const 13)
                        )
                        (local.get $Pmakeblock_arg_177)
                       )
                      )
                     )
                    )
                    (br $switch_result_46
                     (block (result (ref (exact $Array)))
                      (local.set $apply_arg_170
                       (array.get $Array
                        (ref.cast (ref $Array)
                         (local.get $P_fmtty1_100)
                        )
                        (i32.const 1)
                       )
                      )
                      (local.set $apply_funct_171
                       (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
                      )
                      (local.set $Pmakeblock_arg_172
                       (block (result (ref eq))
                        (local.set $call_result1#56
                         (block (result i32)
                          (local.set $scratch_87
                           (tuple.extract 2 0
                            (local.tee $scratch_86
                             (call $concat_fmtty_97
                              (local.get $apply_arg_170)
                              (local.get $P_fmtty2_99)
                              (ref.cast (ref $Env)
                               (local.get $apply_funct_171)
                              )
                             )
                            )
                           )
                          )
                          (local.set $call_result2#57
                           (tuple.extract 2 1
                            (local.get $scratch_86)
                           )
                          )
                          (local.get $scratch_87)
                         )
                        )
                        (if (result (ref eq))
                         (local.get $call_result1#56)
                         (then
                          (return
                           (tuple.make 2
                            (i32.const 1)
                            (local.get $call_result2#57)
                           )
                          )
                         )
                         (else
                          (local.get $call_result2#57)
                         )
                        )
                       )
                      )
                      (array.new_fixed $Array 2
                       (ref.i31
                        (i32.const 12)
                       )
                       (local.get $Pmakeblock_arg_172)
                      )
                     )
                    )
                   )
                   (br $switch_result_46
                    (block (result (ref (exact $Array)))
                     (local.set $apply_arg_165
                      (array.get $Array
                       (ref.cast (ref $Array)
                        (local.get $P_fmtty1_100)
                       )
                       (i32.const 1)
                      )
                     )
                     (local.set $apply_funct_166
                      (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
                     )
                     (local.set $Pmakeblock_arg_167
                      (block (result (ref eq))
                       (local.set $call_result1#58
                        (block (result i32)
                         (local.set $scratch_89
                          (tuple.extract 2 0
                           (local.tee $scratch_88
                            (call $concat_fmtty_97
                             (local.get $apply_arg_165)
                             (local.get $P_fmtty2_99)
                             (ref.cast (ref $Env)
                              (local.get $apply_funct_166)
                             )
                            )
                           )
                          )
                         )
                         (local.set $call_result2#59
                          (tuple.extract 2 1
                           (local.get $scratch_88)
                          )
                         )
                         (local.get $scratch_89)
                        )
                       )
                       (if (result (ref eq))
                        (local.get $call_result1#58)
                        (then
                         (return
                          (tuple.make 2
                           (i32.const 1)
                           (local.get $call_result2#59)
                          )
                         )
                        )
                        (else
                         (local.get $call_result2#59)
                        )
                       )
                      )
                     )
                     (array.new_fixed $Array 2
                      (ref.i31
                       (i32.const 11)
                      )
                      (local.get $Pmakeblock_arg_167)
                     )
                    )
                   )
                  )
                  (br $switch_result_46
                   (block (result (ref (exact $Array)))
                    (local.set $apply_arg_160
                     (array.get $Array
                      (ref.cast (ref $Array)
                       (local.get $P_fmtty1_100)
                      )
                      (i32.const 1)
                     )
                    )
                    (local.set $apply_funct_161
                     (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
                    )
                    (local.set $Pmakeblock_arg_162
                     (block (result (ref eq))
                      (local.set $call_result1#60
                       (block (result i32)
                        (local.set $scratch_91
                         (tuple.extract 2 0
                          (local.tee $scratch_90
                           (call $concat_fmtty_97
                            (local.get $apply_arg_160)
                            (local.get $P_fmtty2_99)
                            (ref.cast (ref $Env)
                             (local.get $apply_funct_161)
                            )
                           )
                          )
                         )
                        )
                        (local.set $call_result2#61
                         (tuple.extract 2 1
                          (local.get $scratch_90)
                         )
                        )
                        (local.get $scratch_91)
                       )
                      )
                      (if (result (ref eq))
                       (local.get $call_result1#60)
                       (then
                        (return
                         (tuple.make 2
                          (i32.const 1)
                          (local.get $call_result2#61)
                         )
                        )
                       )
                       (else
                        (local.get $call_result2#61)
                       )
                      )
                     )
                    )
                    (array.new_fixed $Array 2
                     (ref.i31
                      (i32.const 10)
                     )
                     (local.get $Pmakeblock_arg_162)
                    )
                   )
                  )
                 )
                 (br $switch_result_46
                  (block (result (ref (exact $Array)))
                   (local.set $apply_arg_153
                    (array.get $Array
                     (ref.cast (ref $Array)
                      (local.get $P_fmtty1_100)
                     )
                     (i32.const 3)
                    )
                   )
                   (local.set $apply_funct_154
                    (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
                   )
                   (local.set $Pmakeblock_arg_155
                    (block (result (ref eq))
                     (local.set $call_result1#62
                      (block (result i32)
                       (local.set $scratch_93
                        (tuple.extract 2 0
                         (local.tee $scratch_92
                          (call $concat_fmtty_97
                           (local.get $apply_arg_153)
                           (local.get $P_fmtty2_99)
                           (ref.cast (ref $Env)
                            (local.get $apply_funct_154)
                           )
                          )
                         )
                        )
                       )
                       (local.set $call_result2#63
                        (tuple.extract 2 1
                         (local.get $scratch_92)
                        )
                       )
                       (local.get $scratch_93)
                      )
                     )
                     (if (result (ref eq))
                      (local.get $call_result1#62)
                      (then
                       (return
                        (tuple.make 2
                         (i32.const 1)
                         (local.get $call_result2#63)
                        )
                       )
                      )
                      (else
                       (local.get $call_result2#63)
                      )
                     )
                    )
                   )
                   (local.set $Pmakeblock_arg_156
                    (array.get $Array
                     (ref.cast (ref $Array)
                      (local.get $P_fmtty1_100)
                     )
                     (i32.const 2)
                    )
                   )
                   (local.set $Pmakeblock_arg_157
                    (array.get $Array
                     (ref.cast (ref $Array)
                      (local.get $P_fmtty1_100)
                     )
                     (i32.const 1)
                    )
                   )
                   (array.new_fixed $Array 4
                    (ref.i31
                     (i32.const 9)
                    )
                    (local.get $Pmakeblock_arg_157)
                    (local.get $Pmakeblock_arg_156)
                    (local.get $Pmakeblock_arg_155)
                   )
                  )
                 )
                )
                (br $switch_result_46
                 (block (result (ref (exact $Array)))
                  (local.set $apply_arg_145
                   (array.get $Array
                    (ref.cast (ref $Array)
                     (local.get $P_fmtty1_100)
                    )
                    (i32.const 2)
                   )
                  )
                  (local.set $apply_funct_146
                   (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
                  )
                  (local.set $Pmakeblock_arg_147
                   (block (result (ref eq))
                    (local.set $call_result1#64
                     (block (result i32)
                      (local.set $scratch_95
                       (tuple.extract 2 0
                        (local.tee $scratch_94
                         (call $concat_fmtty_97
                          (local.get $apply_arg_145)
                          (local.get $P_fmtty2_99)
                          (ref.cast (ref $Env)
                           (local.get $apply_funct_146)
                          )
                         )
                        )
                       )
                      )
                      (local.set $call_result2#65
                       (tuple.extract 2 1
                        (local.get $scratch_94)
                       )
                      )
                      (local.get $scratch_95)
                     )
                    )
                    (if (result (ref eq))
                     (local.get $call_result1#64)
                     (then
                      (return
                       (tuple.make 2
                        (i32.const 1)
                        (local.get $call_result2#65)
                       )
                      )
                     )
                     (else
                      (local.get $call_result2#65)
                     )
                    )
                   )
                  )
                  (local.set $Pmakeblock_arg_148
                   (array.get $Array
                    (ref.cast (ref $Array)
                     (local.get $P_fmtty1_100)
                    )
                    (i32.const 1)
                   )
                  )
                  (array.new_fixed $Array 3
                   (ref.i31
                    (i32.const 8)
                   )
                   (local.get $Pmakeblock_arg_148)
                   (local.get $Pmakeblock_arg_147)
                  )
                 )
                )
               )
               (br $switch_result_46
                (block (result (ref (exact $Array)))
                 (local.set $apply_arg_139
                  (array.get $Array
                   (ref.cast (ref $Array)
                    (local.get $P_fmtty1_100)
                   )
                   (i32.const 1)
                  )
                 )
                 (local.set $apply_funct_140
                  (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
                 )
                 (local.set $Pmakeblock_arg_141
                  (block (result (ref eq))
                   (local.set $call_result1#66
                    (block (result i32)
                     (local.set $scratch_97
                      (tuple.extract 2 0
                       (local.tee $scratch_96
                        (call $concat_fmtty_97
                         (local.get $apply_arg_139)
                         (local.get $P_fmtty2_99)
                         (ref.cast (ref $Env)
                          (local.get $apply_funct_140)
                         )
                        )
                       )
                      )
                     )
                     (local.set $call_result2#67
                      (tuple.extract 2 1
                       (local.get $scratch_96)
                      )
                     )
                     (local.get $scratch_97)
                    )
                   )
                   (if (result (ref eq))
                    (local.get $call_result1#66)
                    (then
                     (return
                      (tuple.make 2
                       (i32.const 1)
                       (local.get $call_result2#67)
                      )
                     )
                    )
                    (else
                     (local.get $call_result2#67)
                    )
                   )
                  )
                 )
                 (array.new_fixed $Array 2
                  (ref.i31
                   (i32.const 7)
                  )
                  (local.get $Pmakeblock_arg_141)
                 )
                )
               )
              )
              (br $switch_result_46
               (block (result (ref (exact $Array)))
                (local.set $apply_arg_134
                 (array.get $Array
                  (ref.cast (ref $Array)
                   (local.get $P_fmtty1_100)
                  )
                  (i32.const 1)
                 )
                )
                (local.set $apply_funct_135
                 (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
                )
                (local.set $Pmakeblock_arg_136
                 (block (result (ref eq))
                  (local.set $call_result1#68
                   (block (result i32)
                    (local.set $scratch_99
                     (tuple.extract 2 0
                      (local.tee $scratch_98
                       (call $concat_fmtty_97
                        (local.get $apply_arg_134)
                        (local.get $P_fmtty2_99)
                        (ref.cast (ref $Env)
                         (local.get $apply_funct_135)
                        )
                       )
                      )
                     )
                    )
                    (local.set $call_result2#69
                     (tuple.extract 2 1
                      (local.get $scratch_98)
                     )
                    )
                    (local.get $scratch_99)
                   )
                  )
                  (if (result (ref eq))
                   (local.get $call_result1#68)
                   (then
                    (return
                     (tuple.make 2
                      (i32.const 1)
                      (local.get $call_result2#69)
                     )
                    )
                   )
                   (else
                    (local.get $call_result2#69)
                   )
                  )
                 )
                )
                (array.new_fixed $Array 2
                 (ref.i31
                  (i32.const 6)
                 )
                 (local.get $Pmakeblock_arg_136)
                )
               )
              )
             )
             (br $switch_result_46
              (block (result (ref (exact $Array)))
               (local.set $apply_arg_129
                (array.get $Array
                 (ref.cast (ref $Array)
                  (local.get $P_fmtty1_100)
                 )
                 (i32.const 1)
                )
               )
               (local.set $apply_funct_130
                (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
               )
               (local.set $Pmakeblock_arg_131
                (block (result (ref eq))
                 (local.set $call_result1#70
                  (block (result i32)
                   (local.set $scratch_101
                    (tuple.extract 2 0
                     (local.tee $scratch_100
                      (call $concat_fmtty_97
                       (local.get $apply_arg_129)
                       (local.get $P_fmtty2_99)
                       (ref.cast (ref $Env)
                        (local.get $apply_funct_130)
                       )
                      )
                     )
                    )
                   )
                   (local.set $call_result2#71
                    (tuple.extract 2 1
                     (local.get $scratch_100)
                    )
                   )
                   (local.get $scratch_101)
                  )
                 )
                 (if (result (ref eq))
                  (local.get $call_result1#70)
                  (then
                   (return
                    (tuple.make 2
                     (i32.const 1)
                     (local.get $call_result2#71)
                    )
                   )
                  )
                  (else
                   (local.get $call_result2#71)
                  )
                 )
                )
               )
               (array.new_fixed $Array 2
                (ref.i31
                 (i32.const 5)
                )
                (local.get $Pmakeblock_arg_131)
               )
              )
             )
            )
            (br $switch_result_46
             (block (result (ref (exact $Array)))
              (local.set $apply_arg_124
               (array.get $Array
                (ref.cast (ref $Array)
                 (local.get $P_fmtty1_100)
                )
                (i32.const 1)
               )
              )
              (local.set $apply_funct_125
               (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
              )
              (local.set $Pmakeblock_arg_126
               (block (result (ref eq))
                (local.set $call_result1#72
                 (block (result i32)
                  (local.set $scratch_103
                   (tuple.extract 2 0
                    (local.tee $scratch_102
                     (call $concat_fmtty_97
                      (local.get $apply_arg_124)
                      (local.get $P_fmtty2_99)
                      (ref.cast (ref $Env)
                       (local.get $apply_funct_125)
                      )
                     )
                    )
                   )
                  )
                  (local.set $call_result2#73
                   (tuple.extract 2 1
                    (local.get $scratch_102)
                   )
                  )
                  (local.get $scratch_103)
                 )
                )
                (if (result (ref eq))
                 (local.get $call_result1#72)
                 (then
                  (return
                   (tuple.make 2
                    (i32.const 1)
                    (local.get $call_result2#73)
                   )
                  )
                 )
                 (else
                  (local.get $call_result2#73)
                 )
                )
               )
              )
              (array.new_fixed $Array 2
               (ref.i31
                (i32.const 4)
               )
               (local.get $Pmakeblock_arg_126)
              )
             )
            )
           )
           (br $switch_result_46
            (block (result (ref (exact $Array)))
             (local.set $apply_arg_119
              (array.get $Array
               (ref.cast (ref $Array)
                (local.get $P_fmtty1_100)
               )
               (i32.const 1)
              )
             )
             (local.set $apply_funct_120
              (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
             )
             (local.set $Pmakeblock_arg_121
              (block (result (ref eq))
               (local.set $call_result1#74
                (block (result i32)
                 (local.set $scratch_105
                  (tuple.extract 2 0
                   (local.tee $scratch_104
                    (call $concat_fmtty_97
                     (local.get $apply_arg_119)
                     (local.get $P_fmtty2_99)
                     (ref.cast (ref $Env)
                      (local.get $apply_funct_120)
                     )
                    )
                   )
                  )
                 )
                 (local.set $call_result2#75
                  (tuple.extract 2 1
                   (local.get $scratch_104)
                  )
                 )
                 (local.get $scratch_105)
                )
               )
               (if (result (ref eq))
                (local.get $call_result1#74)
                (then
                 (return
                  (tuple.make 2
                   (i32.const 1)
                   (local.get $call_result2#75)
                  )
                 )
                )
                (else
                 (local.get $call_result2#75)
                )
               )
              )
             )
             (array.new_fixed $Array 2
              (ref.i31
               (i32.const 3)
              )
              (local.get $Pmakeblock_arg_121)
             )
            )
           )
          )
          (br $switch_result_46
           (block (result (ref (exact $Array)))
            (local.set $apply_arg_114
             (array.get $Array
              (ref.cast (ref $Array)
               (local.get $P_fmtty1_100)
              )
              (i32.const 1)
             )
            )
            (local.set $apply_funct_115
             (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
            )
            (local.set $Pmakeblock_arg_116
             (block (result (ref eq))
              (local.set $call_result1#76
               (block (result i32)
                (local.set $scratch_107
                 (tuple.extract 2 0
                  (local.tee $scratch_106
                   (call $concat_fmtty_97
                    (local.get $apply_arg_114)
                    (local.get $P_fmtty2_99)
                    (ref.cast (ref $Env)
                     (local.get $apply_funct_115)
                    )
                   )
                  )
                 )
                )
                (local.set $call_result2#77
                 (tuple.extract 2 1
                  (local.get $scratch_106)
                 )
                )
                (local.get $scratch_107)
               )
              )
              (if (result (ref eq))
               (local.get $call_result1#76)
               (then
                (return
                 (tuple.make 2
                  (i32.const 1)
                  (local.get $call_result2#77)
                 )
                )
               )
               (else
                (local.get $call_result2#77)
               )
              )
             )
            )
            (array.new_fixed $Array 2
             (ref.i31
              (i32.const 2)
             )
             (local.get $Pmakeblock_arg_116)
            )
           )
          )
         )
         (br $switch_result_46
          (block (result (ref (exact $Array)))
           (local.set $apply_arg_109
            (array.get $Array
             (ref.cast (ref $Array)
              (local.get $P_fmtty1_100)
             )
             (i32.const 1)
            )
           )
           (local.set $apply_funct_110
            (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
           )
           (local.set $Pmakeblock_arg_111
            (block (result (ref eq))
             (local.set $call_result1#78
              (block (result i32)
               (local.set $scratch_109
                (tuple.extract 2 0
                 (local.tee $scratch_108
                  (call $concat_fmtty_97
                   (local.get $apply_arg_109)
                   (local.get $P_fmtty2_99)
                   (ref.cast (ref $Env)
                    (local.get $apply_funct_110)
                   )
                  )
                 )
                )
               )
               (local.set $call_result2#79
                (tuple.extract 2 1
                 (local.get $scratch_108)
                )
               )
               (local.get $scratch_109)
              )
             )
             (if (result (ref eq))
              (local.get $call_result1#78)
              (then
               (return
                (tuple.make 2
                 (i32.const 1)
                 (local.get $call_result2#79)
                )
               )
              )
              (else
               (local.get $call_result2#79)
              )
             )
            )
           )
           (array.new_fixed $Array 2
            (ref.i31
             (i32.const 1)
            )
            (local.get $Pmakeblock_arg_111)
           )
          )
         )
        )
        (br $switch_result_46
         (block (result (ref (exact $Array)))
          (local.set $apply_arg_104
           (array.get $Array
            (ref.cast (ref $Array)
             (local.get $P_fmtty1_100)
            )
            (i32.const 1)
           )
          )
          (local.set $apply_funct_105
           (global.get $camlCamlinternalFormatBasics__concat_fmtty_97_closure)
          )
          (local.set $Pmakeblock_arg_106
           (block (result (ref eq))
            (local.set $call_result1#80
             (block (result i32)
              (local.set $scratch_111
               (tuple.extract 2 0
                (local.tee $scratch_110
                 (call $concat_fmtty_97
                  (local.get $apply_arg_104)
                  (local.get $P_fmtty2_99)
                  (ref.cast (ref $Env)
                   (local.get $apply_funct_105)
                  )
                 )
                )
               )
              )
              (local.set $call_result2#81
               (tuple.extract 2 1
                (local.get $scratch_110)
               )
              )
              (local.get $scratch_111)
             )
            )
            (if (result (ref eq))
             (local.get $call_result1#80)
             (then
              (return
               (tuple.make 2
                (i32.const 1)
                (local.get $call_result2#81)
               )
              )
             )
             (else
              (local.get $call_result2#81)
             )
            )
           )
          )
          (array.new_fixed $Array 2
           (ref.i31
            (i32.const 0)
           )
           (local.get $Pmakeblock_arg_106)
          )
         )
        )
       )
      )
     )
     (local.get $switch_result#82)
    )
   )
  )
 )
 (func $concat_fmt_185 (type $Func_2) (param $P_fmt1_188 (ref eq)) (param $P_fmt2_187 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $switch_result#51 (ref eq))
  (local $call_result2#50 (ref eq))
  (local $call_result2#48 (ref eq))
  (local $call_result2#46 (ref eq))
  (local $call_result2#44 (ref eq))
  (local $call_result2#42 (ref eq))
  (local $call_result2#40 (ref eq))
  (local $call_result2#38 (ref eq))
  (local $call_result2#36 (ref eq))
  (local $call_result2#34 (ref eq))
  (local $call_result2#32 (ref eq))
  (local $call_result2#30 (ref eq))
  (local $call_result2#28 (ref eq))
  (local $call_result2#26 (ref eq))
  (local $call_result2#24 (ref eq))
  (local $call_result2#22 (ref eq))
  (local $call_result2#20 (ref eq))
  (local $call_result2#18 (ref eq))
  (local $call_result2#16 (ref eq))
  (local $call_result2#14 (ref eq))
  (local $call_result2#12 (ref eq))
  (local $call_result2#10 (ref eq))
  (local $call_result2#8 (ref eq))
  (local $call_result2#6 (ref eq))
  (local $call_result2#4 (ref eq))
  (local $call_result2#2 (ref eq))
  (local $call_result1#49 i32)
  (local $call_result1#47 i32)
  (local $call_result1#45 i32)
  (local $call_result1#43 i32)
  (local $call_result1#41 i32)
  (local $call_result1#39 i32)
  (local $call_result1#37 i32)
  (local $call_result1#35 i32)
  (local $call_result1#33 i32)
  (local $call_result1#31 i32)
  (local $call_result1#29 i32)
  (local $call_result1#27 i32)
  (local $call_result1#25 i32)
  (local $call_result1#23 i32)
  (local $call_result1#21 i32)
  (local $call_result1#19 i32)
  (local $call_result1#17 i32)
  (local $call_result1#15 i32)
  (local $call_result1#13 i32)
  (local $call_result1#11 i32)
  (local $call_result1#9 i32)
  (local $call_result1#7 i32)
  (local $call_result1#5 i32)
  (local $call_result1#3 i32)
  (local $call_result1#1 i32)
  (local $apply_funct_375 (ref eq))
  (local $apply_funct_367 (ref eq))
  (local $apply_funct_361 (ref eq))
  (local $apply_funct_355 (ref eq))
  (local $apply_funct_347 (ref eq))
  (local $apply_funct_340 (ref eq))
  (local $apply_funct_334 (ref eq))
  (local $apply_funct_327 (ref eq))
  (local $apply_funct_321 (ref eq))
  (local $apply_funct_316 (ref eq))
  (local $apply_funct_309 (ref eq))
  (local $apply_funct_300 (ref eq))
  (local $apply_funct_292 (ref eq))
  (local $apply_funct_285 (ref eq))
  (local $apply_funct_279 (ref eq))
  (local $apply_funct_273 (ref eq))
  (local $apply_funct_264 (ref eq))
  (local $apply_funct_253 (ref eq))
  (local $apply_funct_242 (ref eq))
  (local $apply_funct_231 (ref eq))
  (local $apply_funct_220 (ref eq))
  (local $apply_funct_211 (ref eq))
  (local $apply_funct_204 (ref eq))
  (local $apply_funct_198 (ref eq))
  (local $apply_funct_193 (ref eq))
  (local $apply_arg_374 (ref eq))
  (local $apply_arg_366 (ref eq))
  (local $apply_arg_360 (ref eq))
  (local $apply_arg_354 (ref eq))
  (local $apply_arg_346 (ref eq))
  (local $apply_arg_339 (ref eq))
  (local $apply_arg_333 (ref eq))
  (local $apply_arg_326 (ref eq))
  (local $apply_arg_320 (ref eq))
  (local $apply_arg_315 (ref eq))
  (local $apply_arg_308 (ref eq))
  (local $apply_arg_299 (ref eq))
  (local $apply_arg_291 (ref eq))
  (local $apply_arg_284 (ref eq))
  (local $apply_arg_278 (ref eq))
  (local $apply_arg_272 (ref eq))
  (local $apply_arg_263 (ref eq))
  (local $apply_arg_252 (ref eq))
  (local $apply_arg_241 (ref eq))
  (local $apply_arg_230 (ref eq))
  (local $apply_arg_219 (ref eq))
  (local $apply_arg_210 (ref eq))
  (local $apply_arg_203 (ref eq))
  (local $apply_arg_197 (ref eq))
  (local $apply_arg_192 (ref eq))
  (local $Pmakeblock_arg_378 (ref eq))
  (local $Pmakeblock_arg_377 (ref eq))
  (local $Pmakeblock_arg_376 (ref eq))
  (local $Pmakeblock_arg_369 (ref eq))
  (local $Pmakeblock_arg_368 (ref eq))
  (local $Pmakeblock_arg_362 (ref eq))
  (local $Pmakeblock_arg_357 (ref eq))
  (local $Pmakeblock_arg_356 (ref eq))
  (local $Pmakeblock_arg_350 (ref eq))
  (local $Pmakeblock_arg_349 (ref eq))
  (local $Pmakeblock_arg_348 (ref eq))
  (local $Pmakeblock_arg_341 (ref eq))
  (local $Pmakeblock_arg_336 (ref eq))
  (local $Pmakeblock_arg_335 (ref eq))
  (local $Pmakeblock_arg_329 (ref eq))
  (local $Pmakeblock_arg_328 (ref eq))
  (local $Pmakeblock_arg_322 (ref eq))
  (local $Pmakeblock_arg_317 (ref eq))
  (local $Pmakeblock_arg_312 (ref eq))
  (local $Pmakeblock_arg_311 (ref eq))
  (local $Pmakeblock_arg_310 (ref eq))
  (local $Pmakeblock_arg_303 (ref eq))
  (local $Pmakeblock_arg_302 (ref eq))
  (local $Pmakeblock_arg_301 (ref eq))
  (local $Pmakeblock_arg_294 (ref eq))
  (local $Pmakeblock_arg_293 (ref eq))
  (local $Pmakeblock_arg_287 (ref eq))
  (local $Pmakeblock_arg_286 (ref eq))
  (local $Pmakeblock_arg_280 (ref eq))
  (local $Pmakeblock_arg_275 (ref eq))
  (local $Pmakeblock_arg_274 (ref eq))
  (local $Pmakeblock_arg_268 (ref eq))
  (local $Pmakeblock_arg_267 (ref eq))
  (local $Pmakeblock_arg_266 (ref eq))
  (local $Pmakeblock_arg_265 (ref eq))
  (local $Pmakeblock_arg_257 (ref eq))
  (local $Pmakeblock_arg_256 (ref eq))
  (local $Pmakeblock_arg_255 (ref eq))
  (local $Pmakeblock_arg_254 (ref eq))
  (local $Pmakeblock_arg_246 (ref eq))
  (local $Pmakeblock_arg_245 (ref eq))
  (local $Pmakeblock_arg_244 (ref eq))
  (local $Pmakeblock_arg_243 (ref eq))
  (local $Pmakeblock_arg_235 (ref eq))
  (local $Pmakeblock_arg_234 (ref eq))
  (local $Pmakeblock_arg_233 (ref eq))
  (local $Pmakeblock_arg_232 (ref eq))
  (local $Pmakeblock_arg_224 (ref eq))
  (local $Pmakeblock_arg_223 (ref eq))
  (local $Pmakeblock_arg_222 (ref eq))
  (local $Pmakeblock_arg_221 (ref eq))
  (local $Pmakeblock_arg_213 (ref eq))
  (local $Pmakeblock_arg_212 (ref eq))
  (local $Pmakeblock_arg_206 (ref eq))
  (local $Pmakeblock_arg_205 (ref eq))
  (local $Pmakeblock_arg_199 (ref eq))
  (local $Pmakeblock_arg_194 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_162 i32)
  (local $scratch_163 (tuple i32 (ref eq)))
  (local $scratch_164 i32)
  (local $scratch_165 (tuple i32 (ref eq)))
  (local $scratch_166 i32)
  (local $scratch_167 (tuple i32 (ref eq)))
  (local $scratch_168 i32)
  (local $scratch_169 (tuple i32 (ref eq)))
  (local $scratch_170 i32)
  (local $scratch_171 (tuple i32 (ref eq)))
  (local $scratch_172 i32)
  (local $scratch_173 (tuple i32 (ref eq)))
  (local $scratch_174 i32)
  (local $scratch_175 (tuple i32 (ref eq)))
  (local $scratch_176 i32)
  (local $scratch_177 (tuple i32 (ref eq)))
  (local $scratch_178 i32)
  (local $scratch_179 (tuple i32 (ref eq)))
  (local $scratch_180 i32)
  (local $scratch_181 (tuple i32 (ref eq)))
  (local $scratch_182 i32)
  (local $scratch_183 (tuple i32 (ref eq)))
  (local $scratch_184 i32)
  (local $scratch_185 (tuple i32 (ref eq)))
  (local $scratch_186 i32)
  (local $scratch_187 (tuple i32 (ref eq)))
  (local $scratch_188 i32)
  (local $scratch_189 (tuple i32 (ref eq)))
  (local $scratch_190 i32)
  (local $scratch_191 (tuple i32 (ref eq)))
  (local $scratch_192 i32)
  (local $scratch_193 (tuple i32 (ref eq)))
  (local $scratch_194 i32)
  (local $scratch_195 (tuple i32 (ref eq)))
  (local $scratch_196 i32)
  (local $scratch_197 (tuple i32 (ref eq)))
  (local $scratch_198 i32)
  (local $scratch_199 (tuple i32 (ref eq)))
  (local $scratch_200 i32)
  (local $scratch_201 (tuple i32 (ref eq)))
  (local $scratch_202 i32)
  (local $scratch_203 (tuple i32 (ref eq)))
  (local $scratch_204 i32)
  (local $scratch_205 (tuple i32 (ref eq)))
  (local $scratch_206 i32)
  (local $scratch_207 (tuple i32 (ref eq)))
  (local $scratch_208 i32)
  (local $scratch_209 (tuple i32 (ref eq)))
  (local $scratch_210 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (block $!switch_result_28 (result (ref eq))
     (local.set $switch_result#51
      (block $switch_result_28 (result (ref eq))
       (block
        (block $switch_0_3
         (block $switch_1_4
          (block $switch_2_5
           (block $switch_3_6
            (block $switch_4_7
             (block $switch_5_8
              (block $switch_6_9
               (block $switch_7_10
                (block $switch_8_11
                 (block $switch_9_12
                  (block $switch_10_13
                   (block $switch_11_14
                    (block $switch_12_15
                     (block $switch_13_16
                      (block $switch_14_17
                       (block $switch_15_18
                        (block $switch_16_19
                         (block $switch_17_20
                          (block $switch_18_21
                           (block $switch_19_22
                            (block $switch_20_23
                             (block $switch_21_24
                              (block $switch_22_25
                               (block $switch_23_26
                                (block $switch_24_27
                                 (block $switch_0_2
                                  (if
                                   (ref.test (ref i31)
                                    (local.get $P_fmt1_188)
                                   )
                                   (then
                                    (br_table $switch_0_2 $switch_0_2
                                     (i31.get_s
                                      (ref.cast (ref i31)
                                       (local.get $P_fmt1_188)
                                      )
                                     )
                                    )
                                   )
                                   (else
                                    (br_table $switch_0_3 $switch_1_4 $switch_2_5 $switch_3_6 $switch_4_7 $switch_5_8 $switch_6_9 $switch_7_10 $switch_8_11 $switch_9_12 $switch_10_13 $switch_11_14 $switch_12_15 $switch_13_16 $switch_14_17 $switch_15_18 $switch_16_19 $switch_17_20 $switch_18_21 $switch_19_22 $switch_20_23 $switch_21_24 $switch_22_25 $switch_23_26 $switch_24_27 $switch_24_27
                                     (i31.get_s
                                      (ref.cast (ref i31)
                                       (array.get $Array
                                        (ref.cast (ref $Array)
                                         (local.get $P_fmt1_188)
                                        )
                                        (i32.const 0)
                                       )
                                      )
                                     )
                                    )
                                   )
                                  )
                                 )
                                 (br $switch_result_28
                                  (local.get $P_fmt2_187)
                                 )
                                )
                                (br $switch_result_28
                                 (block (result (ref (exact $Array)))
                                  (local.set $apply_arg_374
                                   (array.get $Array
                                    (ref.cast (ref $Array)
                                     (local.get $P_fmt1_188)
                                    )
                                    (i32.const 3)
                                   )
                                  )
                                  (local.set $apply_funct_375
                                   (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                                  )
                                  (local.set $Pmakeblock_arg_376
                                   (block (result (ref eq))
                                    (local.set $call_result1#1
                                     (block (result i32)
                                      (local.set $scratch_162
                                       (tuple.extract 2 0
                                        (local.tee $scratch
                                         (call $concat_fmt_185
                                          (local.get $apply_arg_374)
                                          (local.get $P_fmt2_187)
                                          (ref.cast (ref $Env)
                                           (local.get $apply_funct_375)
                                          )
                                         )
                                        )
                                       )
                                      )
                                      (local.set $call_result2#2
                                       (tuple.extract 2 1
                                        (local.get $scratch)
                                       )
                                      )
                                      (local.get $scratch_162)
                                     )
                                    )
                                    (if (result (ref eq))
                                     (local.get $call_result1#1)
                                     (then
                                      (return
                                       (tuple.make 2
                                        (i32.const 1)
                                        (local.get $call_result2#2)
                                       )
                                      )
                                     )
                                     (else
                                      (local.get $call_result2#2)
                                     )
                                    )
                                   )
                                  )
                                  (local.set $Pmakeblock_arg_377
                                   (array.get $Array
                                    (ref.cast (ref $Array)
                                     (local.get $P_fmt1_188)
                                    )
                                    (i32.const 2)
                                   )
                                  )
                                  (local.set $Pmakeblock_arg_378
                                   (array.get $Array
                                    (ref.cast (ref $Array)
                                     (local.get $P_fmt1_188)
                                    )
                                    (i32.const 1)
                                   )
                                  )
                                  (array.new_fixed $Array 4
                                   (ref.i31
                                    (i32.const 24)
                                   )
                                   (local.get $Pmakeblock_arg_378)
                                   (local.get $Pmakeblock_arg_377)
                                   (local.get $Pmakeblock_arg_376)
                                  )
                                 )
                                )
                               )
                               (br $switch_result_28
                                (block (result (ref (exact $Array)))
                                 (local.set $apply_arg_366
                                  (array.get $Array
                                   (ref.cast (ref $Array)
                                    (local.get $P_fmt1_188)
                                   )
                                   (i32.const 2)
                                  )
                                 )
                                 (local.set $apply_funct_367
                                  (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                                 )
                                 (local.set $Pmakeblock_arg_368
                                  (block (result (ref eq))
                                   (local.set $call_result1#3
                                    (block (result i32)
                                     (local.set $scratch_164
                                      (tuple.extract 2 0
                                       (local.tee $scratch_163
                                        (call $concat_fmt_185
                                         (local.get $apply_arg_366)
                                         (local.get $P_fmt2_187)
                                         (ref.cast (ref $Env)
                                          (local.get $apply_funct_367)
                                         )
                                        )
                                       )
                                      )
                                     )
                                     (local.set $call_result2#4
                                      (tuple.extract 2 1
                                       (local.get $scratch_163)
                                      )
                                     )
                                     (local.get $scratch_164)
                                    )
                                   )
                                   (if (result (ref eq))
                                    (local.get $call_result1#3)
                                    (then
                                     (return
                                      (tuple.make 2
                                       (i32.const 1)
                                       (local.get $call_result2#4)
                                      )
                                     )
                                    )
                                    (else
                                     (local.get $call_result2#4)
                                    )
                                   )
                                  )
                                 )
                                 (local.set $Pmakeblock_arg_369
                                  (array.get $Array
                                   (ref.cast (ref $Array)
                                    (local.get $P_fmt1_188)
                                   )
                                   (i32.const 1)
                                  )
                                 )
                                 (array.new_fixed $Array 3
                                  (ref.i31
                                   (i32.const 23)
                                  )
                                  (local.get $Pmakeblock_arg_369)
                                  (local.get $Pmakeblock_arg_368)
                                 )
                                )
                               )
                              )
                              (br $switch_result_28
                               (block (result (ref (exact $Array)))
                                (local.set $apply_arg_360
                                 (array.get $Array
                                  (ref.cast (ref $Array)
                                   (local.get $P_fmt1_188)
                                  )
                                  (i32.const 1)
                                 )
                                )
                                (local.set $apply_funct_361
                                 (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                                )
                                (local.set $Pmakeblock_arg_362
                                 (block (result (ref eq))
                                  (local.set $call_result1#5
                                   (block (result i32)
                                    (local.set $scratch_166
                                     (tuple.extract 2 0
                                      (local.tee $scratch_165
                                       (call $concat_fmt_185
                                        (local.get $apply_arg_360)
                                        (local.get $P_fmt2_187)
                                        (ref.cast (ref $Env)
                                         (local.get $apply_funct_361)
                                        )
                                       )
                                      )
                                     )
                                    )
                                    (local.set $call_result2#6
                                     (tuple.extract 2 1
                                      (local.get $scratch_165)
                                     )
                                    )
                                    (local.get $scratch_166)
                                   )
                                  )
                                  (if (result (ref eq))
                                   (local.get $call_result1#5)
                                   (then
                                    (return
                                     (tuple.make 2
                                      (i32.const 1)
                                      (local.get $call_result2#6)
                                     )
                                    )
                                   )
                                   (else
                                    (local.get $call_result2#6)
                                   )
                                  )
                                 )
                                )
                                (array.new_fixed $Array 2
                                 (ref.i31
                                  (i32.const 22)
                                 )
                                 (local.get $Pmakeblock_arg_362)
                                )
                               )
                              )
                             )
                             (br $switch_result_28
                              (block (result (ref (exact $Array)))
                               (local.set $apply_arg_354
                                (array.get $Array
                                 (ref.cast (ref $Array)
                                  (local.get $P_fmt1_188)
                                 )
                                 (i32.const 2)
                                )
                               )
                               (local.set $apply_funct_355
                                (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                               )
                               (local.set $Pmakeblock_arg_356
                                (block (result (ref eq))
                                 (local.set $call_result1#7
                                  (block (result i32)
                                   (local.set $scratch_168
                                    (tuple.extract 2 0
                                     (local.tee $scratch_167
                                      (call $concat_fmt_185
                                       (local.get $apply_arg_354)
                                       (local.get $P_fmt2_187)
                                       (ref.cast (ref $Env)
                                        (local.get $apply_funct_355)
                                       )
                                      )
                                     )
                                    )
                                   )
                                   (local.set $call_result2#8
                                    (tuple.extract 2 1
                                     (local.get $scratch_167)
                                    )
                                   )
                                   (local.get $scratch_168)
                                  )
                                 )
                                 (if (result (ref eq))
                                  (local.get $call_result1#7)
                                  (then
                                   (return
                                    (tuple.make 2
                                     (i32.const 1)
                                     (local.get $call_result2#8)
                                    )
                                   )
                                  )
                                  (else
                                   (local.get $call_result2#8)
                                  )
                                 )
                                )
                               )
                               (local.set $Pmakeblock_arg_357
                                (array.get $Array
                                 (ref.cast (ref $Array)
                                  (local.get $P_fmt1_188)
                                 )
                                 (i32.const 1)
                                )
                               )
                               (array.new_fixed $Array 3
                                (ref.i31
                                 (i32.const 21)
                                )
                                (local.get $Pmakeblock_arg_357)
                                (local.get $Pmakeblock_arg_356)
                               )
                              )
                             )
                            )
                            (br $switch_result_28
                             (block (result (ref (exact $Array)))
                              (local.set $apply_arg_346
                               (array.get $Array
                                (ref.cast (ref $Array)
                                 (local.get $P_fmt1_188)
                                )
                                (i32.const 3)
                               )
                              )
                              (local.set $apply_funct_347
                               (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                              )
                              (local.set $Pmakeblock_arg_348
                               (block (result (ref eq))
                                (local.set $call_result1#9
                                 (block (result i32)
                                  (local.set $scratch_170
                                   (tuple.extract 2 0
                                    (local.tee $scratch_169
                                     (call $concat_fmt_185
                                      (local.get $apply_arg_346)
                                      (local.get $P_fmt2_187)
                                      (ref.cast (ref $Env)
                                       (local.get $apply_funct_347)
                                      )
                                     )
                                    )
                                   )
                                  )
                                  (local.set $call_result2#10
                                   (tuple.extract 2 1
                                    (local.get $scratch_169)
                                   )
                                  )
                                  (local.get $scratch_170)
                                 )
                                )
                                (if (result (ref eq))
                                 (local.get $call_result1#9)
                                 (then
                                  (return
                                   (tuple.make 2
                                    (i32.const 1)
                                    (local.get $call_result2#10)
                                   )
                                  )
                                 )
                                 (else
                                  (local.get $call_result2#10)
                                 )
                                )
                               )
                              )
                              (local.set $Pmakeblock_arg_349
                               (array.get $Array
                                (ref.cast (ref $Array)
                                 (local.get $P_fmt1_188)
                                )
                                (i32.const 2)
                               )
                              )
                              (local.set $Pmakeblock_arg_350
                               (array.get $Array
                                (ref.cast (ref $Array)
                                 (local.get $P_fmt1_188)
                                )
                                (i32.const 1)
                               )
                              )
                              (array.new_fixed $Array 4
                               (ref.i31
                                (i32.const 20)
                               )
                               (local.get $Pmakeblock_arg_350)
                               (local.get $Pmakeblock_arg_349)
                               (local.get $Pmakeblock_arg_348)
                              )
                             )
                            )
                           )
                           (br $switch_result_28
                            (block (result (ref (exact $Array)))
                             (local.set $apply_arg_339
                              (array.get $Array
                               (ref.cast (ref $Array)
                                (local.get $P_fmt1_188)
                               )
                               (i32.const 1)
                              )
                             )
                             (local.set $apply_funct_340
                              (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                             )
                             (local.set $Pmakeblock_arg_341
                              (block (result (ref eq))
                               (local.set $call_result1#11
                                (block (result i32)
                                 (local.set $scratch_172
                                  (tuple.extract 2 0
                                   (local.tee $scratch_171
                                    (call $concat_fmt_185
                                     (local.get $apply_arg_339)
                                     (local.get $P_fmt2_187)
                                     (ref.cast (ref $Env)
                                      (local.get $apply_funct_340)
                                     )
                                    )
                                   )
                                  )
                                 )
                                 (local.set $call_result2#12
                                  (tuple.extract 2 1
                                   (local.get $scratch_171)
                                  )
                                 )
                                 (local.get $scratch_172)
                                )
                               )
                               (if (result (ref eq))
                                (local.get $call_result1#11)
                                (then
                                 (return
                                  (tuple.make 2
                                   (i32.const 1)
                                   (local.get $call_result2#12)
                                  )
                                 )
                                )
                                (else
                                 (local.get $call_result2#12)
                                )
                               )
                              )
                             )
                             (array.new_fixed $Array 2
                              (ref.i31
                               (i32.const 19)
                              )
                              (local.get $Pmakeblock_arg_341)
                             )
                            )
                           )
                          )
                          (br $switch_result_28
                           (block (result (ref (exact $Array)))
                            (local.set $apply_arg_333
                             (array.get $Array
                              (ref.cast (ref $Array)
                               (local.get $P_fmt1_188)
                              )
                              (i32.const 2)
                             )
                            )
                            (local.set $apply_funct_334
                             (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                            )
                            (local.set $Pmakeblock_arg_335
                             (block (result (ref eq))
                              (local.set $call_result1#13
                               (block (result i32)
                                (local.set $scratch_174
                                 (tuple.extract 2 0
                                  (local.tee $scratch_173
                                   (call $concat_fmt_185
                                    (local.get $apply_arg_333)
                                    (local.get $P_fmt2_187)
                                    (ref.cast (ref $Env)
                                     (local.get $apply_funct_334)
                                    )
                                   )
                                  )
                                 )
                                )
                                (local.set $call_result2#14
                                 (tuple.extract 2 1
                                  (local.get $scratch_173)
                                 )
                                )
                                (local.get $scratch_174)
                               )
                              )
                              (if (result (ref eq))
                               (local.get $call_result1#13)
                               (then
                                (return
                                 (tuple.make 2
                                  (i32.const 1)
                                  (local.get $call_result2#14)
                                 )
                                )
                               )
                               (else
                                (local.get $call_result2#14)
                               )
                              )
                             )
                            )
                            (local.set $Pmakeblock_arg_336
                             (array.get $Array
                              (ref.cast (ref $Array)
                               (local.get $P_fmt1_188)
                              )
                              (i32.const 1)
                             )
                            )
                            (array.new_fixed $Array 3
                             (ref.i31
                              (i32.const 18)
                             )
                             (local.get $Pmakeblock_arg_336)
                             (local.get $Pmakeblock_arg_335)
                            )
                           )
                          )
                         )
                         (br $switch_result_28
                          (block (result (ref (exact $Array)))
                           (local.set $apply_arg_326
                            (array.get $Array
                             (ref.cast (ref $Array)
                              (local.get $P_fmt1_188)
                             )
                             (i32.const 2)
                            )
                           )
                           (local.set $apply_funct_327
                            (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                           )
                           (local.set $Pmakeblock_arg_328
                            (block (result (ref eq))
                             (local.set $call_result1#15
                              (block (result i32)
                               (local.set $scratch_176
                                (tuple.extract 2 0
                                 (local.tee $scratch_175
                                  (call $concat_fmt_185
                                   (local.get $apply_arg_326)
                                   (local.get $P_fmt2_187)
                                   (ref.cast (ref $Env)
                                    (local.get $apply_funct_327)
                                   )
                                  )
                                 )
                                )
                               )
                               (local.set $call_result2#16
                                (tuple.extract 2 1
                                 (local.get $scratch_175)
                                )
                               )
                               (local.get $scratch_176)
                              )
                             )
                             (if (result (ref eq))
                              (local.get $call_result1#15)
                              (then
                               (return
                                (tuple.make 2
                                 (i32.const 1)
                                 (local.get $call_result2#16)
                                )
                               )
                              )
                              (else
                               (local.get $call_result2#16)
                              )
                             )
                            )
                           )
                           (local.set $Pmakeblock_arg_329
                            (array.get $Array
                             (ref.cast (ref $Array)
                              (local.get $P_fmt1_188)
                             )
                             (i32.const 1)
                            )
                           )
                           (array.new_fixed $Array 3
                            (ref.i31
                             (i32.const 17)
                            )
                            (local.get $Pmakeblock_arg_329)
                            (local.get $Pmakeblock_arg_328)
                           )
                          )
                         )
                        )
                        (br $switch_result_28
                         (block (result (ref (exact $Array)))
                          (local.set $apply_arg_320
                           (array.get $Array
                            (ref.cast (ref $Array)
                             (local.get $P_fmt1_188)
                            )
                            (i32.const 1)
                           )
                          )
                          (local.set $apply_funct_321
                           (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                          )
                          (local.set $Pmakeblock_arg_322
                           (block (result (ref eq))
                            (local.set $call_result1#17
                             (block (result i32)
                              (local.set $scratch_178
                               (tuple.extract 2 0
                                (local.tee $scratch_177
                                 (call $concat_fmt_185
                                  (local.get $apply_arg_320)
                                  (local.get $P_fmt2_187)
                                  (ref.cast (ref $Env)
                                   (local.get $apply_funct_321)
                                  )
                                 )
                                )
                               )
                              )
                              (local.set $call_result2#18
                               (tuple.extract 2 1
                                (local.get $scratch_177)
                               )
                              )
                              (local.get $scratch_178)
                             )
                            )
                            (if (result (ref eq))
                             (local.get $call_result1#17)
                             (then
                              (return
                               (tuple.make 2
                                (i32.const 1)
                                (local.get $call_result2#18)
                               )
                              )
                             )
                             (else
                              (local.get $call_result2#18)
                             )
                            )
                           )
                          )
                          (array.new_fixed $Array 2
                           (ref.i31
                            (i32.const 16)
                           )
                           (local.get $Pmakeblock_arg_322)
                          )
                         )
                        )
                       )
                       (br $switch_result_28
                        (block (result (ref (exact $Array)))
                         (local.set $apply_arg_315
                          (array.get $Array
                           (ref.cast (ref $Array)
                            (local.get $P_fmt1_188)
                           )
                           (i32.const 1)
                          )
                         )
                         (local.set $apply_funct_316
                          (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                         )
                         (local.set $Pmakeblock_arg_317
                          (block (result (ref eq))
                           (local.set $call_result1#19
                            (block (result i32)
                             (local.set $scratch_180
                              (tuple.extract 2 0
                               (local.tee $scratch_179
                                (call $concat_fmt_185
                                 (local.get $apply_arg_315)
                                 (local.get $P_fmt2_187)
                                 (ref.cast (ref $Env)
                                  (local.get $apply_funct_316)
                                 )
                                )
                               )
                              )
                             )
                             (local.set $call_result2#20
                              (tuple.extract 2 1
                               (local.get $scratch_179)
                              )
                             )
                             (local.get $scratch_180)
                            )
                           )
                           (if (result (ref eq))
                            (local.get $call_result1#19)
                            (then
                             (return
                              (tuple.make 2
                               (i32.const 1)
                               (local.get $call_result2#20)
                              )
                             )
                            )
                            (else
                             (local.get $call_result2#20)
                            )
                           )
                          )
                         )
                         (array.new_fixed $Array 2
                          (ref.i31
                           (i32.const 15)
                          )
                          (local.get $Pmakeblock_arg_317)
                         )
                        )
                       )
                      )
                      (br $switch_result_28
                       (block (result (ref (exact $Array)))
                        (local.set $apply_arg_308
                         (array.get $Array
                          (ref.cast (ref $Array)
                           (local.get $P_fmt1_188)
                          )
                          (i32.const 3)
                         )
                        )
                        (local.set $apply_funct_309
                         (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                        )
                        (local.set $Pmakeblock_arg_310
                         (block (result (ref eq))
                          (local.set $call_result1#21
                           (block (result i32)
                            (local.set $scratch_182
                             (tuple.extract 2 0
                              (local.tee $scratch_181
                               (call $concat_fmt_185
                                (local.get $apply_arg_308)
                                (local.get $P_fmt2_187)
                                (ref.cast (ref $Env)
                                 (local.get $apply_funct_309)
                                )
                               )
                              )
                             )
                            )
                            (local.set $call_result2#22
                             (tuple.extract 2 1
                              (local.get $scratch_181)
                             )
                            )
                            (local.get $scratch_182)
                           )
                          )
                          (if (result (ref eq))
                           (local.get $call_result1#21)
                           (then
                            (return
                             (tuple.make 2
                              (i32.const 1)
                              (local.get $call_result2#22)
                             )
                            )
                           )
                           (else
                            (local.get $call_result2#22)
                           )
                          )
                         )
                        )
                        (local.set $Pmakeblock_arg_311
                         (array.get $Array
                          (ref.cast (ref $Array)
                           (local.get $P_fmt1_188)
                          )
                          (i32.const 2)
                         )
                        )
                        (local.set $Pmakeblock_arg_312
                         (array.get $Array
                          (ref.cast (ref $Array)
                           (local.get $P_fmt1_188)
                          )
                          (i32.const 1)
                         )
                        )
                        (array.new_fixed $Array 4
                         (ref.i31
                          (i32.const 14)
                         )
                         (local.get $Pmakeblock_arg_312)
                         (local.get $Pmakeblock_arg_311)
                         (local.get $Pmakeblock_arg_310)
                        )
                       )
                      )
                     )
                     (br $switch_result_28
                      (block (result (ref (exact $Array)))
                       (local.set $apply_arg_299
                        (array.get $Array
                         (ref.cast (ref $Array)
                          (local.get $P_fmt1_188)
                         )
                         (i32.const 3)
                        )
                       )
                       (local.set $apply_funct_300
                        (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                       )
                       (local.set $Pmakeblock_arg_301
                        (block (result (ref eq))
                         (local.set $call_result1#23
                          (block (result i32)
                           (local.set $scratch_184
                            (tuple.extract 2 0
                             (local.tee $scratch_183
                              (call $concat_fmt_185
                               (local.get $apply_arg_299)
                               (local.get $P_fmt2_187)
                               (ref.cast (ref $Env)
                                (local.get $apply_funct_300)
                               )
                              )
                             )
                            )
                           )
                           (local.set $call_result2#24
                            (tuple.extract 2 1
                             (local.get $scratch_183)
                            )
                           )
                           (local.get $scratch_184)
                          )
                         )
                         (if (result (ref eq))
                          (local.get $call_result1#23)
                          (then
                           (return
                            (tuple.make 2
                             (i32.const 1)
                             (local.get $call_result2#24)
                            )
                           )
                          )
                          (else
                           (local.get $call_result2#24)
                          )
                         )
                        )
                       )
                       (local.set $Pmakeblock_arg_302
                        (array.get $Array
                         (ref.cast (ref $Array)
                          (local.get $P_fmt1_188)
                         )
                         (i32.const 2)
                        )
                       )
                       (local.set $Pmakeblock_arg_303
                        (array.get $Array
                         (ref.cast (ref $Array)
                          (local.get $P_fmt1_188)
                         )
                         (i32.const 1)
                        )
                       )
                       (array.new_fixed $Array 4
                        (ref.i31
                         (i32.const 13)
                        )
                        (local.get $Pmakeblock_arg_303)
                        (local.get $Pmakeblock_arg_302)
                        (local.get $Pmakeblock_arg_301)
                       )
                      )
                     )
                    )
                    (br $switch_result_28
                     (block (result (ref (exact $Array)))
                      (local.set $apply_arg_291
                       (array.get $Array
                        (ref.cast (ref $Array)
                         (local.get $P_fmt1_188)
                        )
                        (i32.const 2)
                       )
                      )
                      (local.set $apply_funct_292
                       (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                      )
                      (local.set $Pmakeblock_arg_293
                       (block (result (ref eq))
                        (local.set $call_result1#25
                         (block (result i32)
                          (local.set $scratch_186
                           (tuple.extract 2 0
                            (local.tee $scratch_185
                             (call $concat_fmt_185
                              (local.get $apply_arg_291)
                              (local.get $P_fmt2_187)
                              (ref.cast (ref $Env)
                               (local.get $apply_funct_292)
                              )
                             )
                            )
                           )
                          )
                          (local.set $call_result2#26
                           (tuple.extract 2 1
                            (local.get $scratch_185)
                           )
                          )
                          (local.get $scratch_186)
                         )
                        )
                        (if (result (ref eq))
                         (local.get $call_result1#25)
                         (then
                          (return
                           (tuple.make 2
                            (i32.const 1)
                            (local.get $call_result2#26)
                           )
                          )
                         )
                         (else
                          (local.get $call_result2#26)
                         )
                        )
                       )
                      )
                      (local.set $Pmakeblock_arg_294
                       (array.get $Array
                        (ref.cast (ref $Array)
                         (local.get $P_fmt1_188)
                        )
                        (i32.const 1)
                       )
                      )
                      (array.new_fixed $Array 3
                       (ref.i31
                        (i32.const 12)
                       )
                       (local.get $Pmakeblock_arg_294)
                       (local.get $Pmakeblock_arg_293)
                      )
                     )
                    )
                   )
                   (br $switch_result_28
                    (block (result (ref (exact $Array)))
                     (local.set $apply_arg_284
                      (array.get $Array
                       (ref.cast (ref $Array)
                        (local.get $P_fmt1_188)
                       )
                       (i32.const 2)
                      )
                     )
                     (local.set $apply_funct_285
                      (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                     )
                     (local.set $Pmakeblock_arg_286
                      (block (result (ref eq))
                       (local.set $call_result1#27
                        (block (result i32)
                         (local.set $scratch_188
                          (tuple.extract 2 0
                           (local.tee $scratch_187
                            (call $concat_fmt_185
                             (local.get $apply_arg_284)
                             (local.get $P_fmt2_187)
                             (ref.cast (ref $Env)
                              (local.get $apply_funct_285)
                             )
                            )
                           )
                          )
                         )
                         (local.set $call_result2#28
                          (tuple.extract 2 1
                           (local.get $scratch_187)
                          )
                         )
                         (local.get $scratch_188)
                        )
                       )
                       (if (result (ref eq))
                        (local.get $call_result1#27)
                        (then
                         (return
                          (tuple.make 2
                           (i32.const 1)
                           (local.get $call_result2#28)
                          )
                         )
                        )
                        (else
                         (local.get $call_result2#28)
                        )
                       )
                      )
                     )
                     (local.set $Pmakeblock_arg_287
                      (array.get $Array
                       (ref.cast (ref $Array)
                        (local.get $P_fmt1_188)
                       )
                       (i32.const 1)
                      )
                     )
                     (array.new_fixed $Array 3
                      (ref.i31
                       (i32.const 11)
                      )
                      (local.get $Pmakeblock_arg_287)
                      (local.get $Pmakeblock_arg_286)
                     )
                    )
                   )
                  )
                  (br $switch_result_28
                   (block (result (ref (exact $Array)))
                    (local.set $apply_arg_278
                     (array.get $Array
                      (ref.cast (ref $Array)
                       (local.get $P_fmt1_188)
                      )
                      (i32.const 1)
                     )
                    )
                    (local.set $apply_funct_279
                     (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                    )
                    (local.set $Pmakeblock_arg_280
                     (block (result (ref eq))
                      (local.set $call_result1#29
                       (block (result i32)
                        (local.set $scratch_190
                         (tuple.extract 2 0
                          (local.tee $scratch_189
                           (call $concat_fmt_185
                            (local.get $apply_arg_278)
                            (local.get $P_fmt2_187)
                            (ref.cast (ref $Env)
                             (local.get $apply_funct_279)
                            )
                           )
                          )
                         )
                        )
                        (local.set $call_result2#30
                         (tuple.extract 2 1
                          (local.get $scratch_189)
                         )
                        )
                        (local.get $scratch_190)
                       )
                      )
                      (if (result (ref eq))
                       (local.get $call_result1#29)
                       (then
                        (return
                         (tuple.make 2
                          (i32.const 1)
                          (local.get $call_result2#30)
                         )
                        )
                       )
                       (else
                        (local.get $call_result2#30)
                       )
                      )
                     )
                    )
                    (array.new_fixed $Array 2
                     (ref.i31
                      (i32.const 10)
                     )
                     (local.get $Pmakeblock_arg_280)
                    )
                   )
                  )
                 )
                 (br $switch_result_28
                  (block (result (ref (exact $Array)))
                   (local.set $apply_arg_272
                    (array.get $Array
                     (ref.cast (ref $Array)
                      (local.get $P_fmt1_188)
                     )
                     (i32.const 2)
                    )
                   )
                   (local.set $apply_funct_273
                    (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                   )
                   (local.set $Pmakeblock_arg_274
                    (block (result (ref eq))
                     (local.set $call_result1#31
                      (block (result i32)
                       (local.set $scratch_192
                        (tuple.extract 2 0
                         (local.tee $scratch_191
                          (call $concat_fmt_185
                           (local.get $apply_arg_272)
                           (local.get $P_fmt2_187)
                           (ref.cast (ref $Env)
                            (local.get $apply_funct_273)
                           )
                          )
                         )
                        )
                       )
                       (local.set $call_result2#32
                        (tuple.extract 2 1
                         (local.get $scratch_191)
                        )
                       )
                       (local.get $scratch_192)
                      )
                     )
                     (if (result (ref eq))
                      (local.get $call_result1#31)
                      (then
                       (return
                        (tuple.make 2
                         (i32.const 1)
                         (local.get $call_result2#32)
                        )
                       )
                      )
                      (else
                       (local.get $call_result2#32)
                      )
                     )
                    )
                   )
                   (local.set $Pmakeblock_arg_275
                    (array.get $Array
                     (ref.cast (ref $Array)
                      (local.get $P_fmt1_188)
                     )
                     (i32.const 1)
                    )
                   )
                   (array.new_fixed $Array 3
                    (ref.i31
                     (i32.const 9)
                    )
                    (local.get $Pmakeblock_arg_275)
                    (local.get $Pmakeblock_arg_274)
                   )
                  )
                 )
                )
                (br $switch_result_28
                 (block (result (ref (exact $Array)))
                  (local.set $apply_arg_263
                   (array.get $Array
                    (ref.cast (ref $Array)
                     (local.get $P_fmt1_188)
                    )
                    (i32.const 4)
                   )
                  )
                  (local.set $apply_funct_264
                   (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                  )
                  (local.set $Pmakeblock_arg_265
                   (block (result (ref eq))
                    (local.set $call_result1#33
                     (block (result i32)
                      (local.set $scratch_194
                       (tuple.extract 2 0
                        (local.tee $scratch_193
                         (call $concat_fmt_185
                          (local.get $apply_arg_263)
                          (local.get $P_fmt2_187)
                          (ref.cast (ref $Env)
                           (local.get $apply_funct_264)
                          )
                         )
                        )
                       )
                      )
                      (local.set $call_result2#34
                       (tuple.extract 2 1
                        (local.get $scratch_193)
                       )
                      )
                      (local.get $scratch_194)
                     )
                    )
                    (if (result (ref eq))
                     (local.get $call_result1#33)
                     (then
                      (return
                       (tuple.make 2
                        (i32.const 1)
                        (local.get $call_result2#34)
                       )
                      )
                     )
                     (else
                      (local.get $call_result2#34)
                     )
                    )
                   )
                  )
                  (local.set $Pmakeblock_arg_266
                   (array.get $Array
                    (ref.cast (ref $Array)
                     (local.get $P_fmt1_188)
                    )
                    (i32.const 3)
                   )
                  )
                  (local.set $Pmakeblock_arg_267
                   (array.get $Array
                    (ref.cast (ref $Array)
                     (local.get $P_fmt1_188)
                    )
                    (i32.const 2)
                   )
                  )
                  (local.set $Pmakeblock_arg_268
                   (array.get $Array
                    (ref.cast (ref $Array)
                     (local.get $P_fmt1_188)
                    )
                    (i32.const 1)
                   )
                  )
                  (array.new_fixed $Array 5
                   (ref.i31
                    (i32.const 8)
                   )
                   (local.get $Pmakeblock_arg_268)
                   (local.get $Pmakeblock_arg_267)
                   (local.get $Pmakeblock_arg_266)
                   (local.get $Pmakeblock_arg_265)
                  )
                 )
                )
               )
               (br $switch_result_28
                (block (result (ref (exact $Array)))
                 (local.set $apply_arg_252
                  (array.get $Array
                   (ref.cast (ref $Array)
                    (local.get $P_fmt1_188)
                   )
                   (i32.const 4)
                  )
                 )
                 (local.set $apply_funct_253
                  (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                 )
                 (local.set $Pmakeblock_arg_254
                  (block (result (ref eq))
                   (local.set $call_result1#35
                    (block (result i32)
                     (local.set $scratch_196
                      (tuple.extract 2 0
                       (local.tee $scratch_195
                        (call $concat_fmt_185
                         (local.get $apply_arg_252)
                         (local.get $P_fmt2_187)
                         (ref.cast (ref $Env)
                          (local.get $apply_funct_253)
                         )
                        )
                       )
                      )
                     )
                     (local.set $call_result2#36
                      (tuple.extract 2 1
                       (local.get $scratch_195)
                      )
                     )
                     (local.get $scratch_196)
                    )
                   )
                   (if (result (ref eq))
                    (local.get $call_result1#35)
                    (then
                     (return
                      (tuple.make 2
                       (i32.const 1)
                       (local.get $call_result2#36)
                      )
                     )
                    )
                    (else
                     (local.get $call_result2#36)
                    )
                   )
                  )
                 )
                 (local.set $Pmakeblock_arg_255
                  (array.get $Array
                   (ref.cast (ref $Array)
                    (local.get $P_fmt1_188)
                   )
                   (i32.const 3)
                  )
                 )
                 (local.set $Pmakeblock_arg_256
                  (array.get $Array
                   (ref.cast (ref $Array)
                    (local.get $P_fmt1_188)
                   )
                   (i32.const 2)
                  )
                 )
                 (local.set $Pmakeblock_arg_257
                  (array.get $Array
                   (ref.cast (ref $Array)
                    (local.get $P_fmt1_188)
                   )
                   (i32.const 1)
                  )
                 )
                 (array.new_fixed $Array 5
                  (ref.i31
                   (i32.const 7)
                  )
                  (local.get $Pmakeblock_arg_257)
                  (local.get $Pmakeblock_arg_256)
                  (local.get $Pmakeblock_arg_255)
                  (local.get $Pmakeblock_arg_254)
                 )
                )
               )
              )
              (br $switch_result_28
               (block (result (ref (exact $Array)))
                (local.set $apply_arg_241
                 (array.get $Array
                  (ref.cast (ref $Array)
                   (local.get $P_fmt1_188)
                  )
                  (i32.const 4)
                 )
                )
                (local.set $apply_funct_242
                 (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
                )
                (local.set $Pmakeblock_arg_243
                 (block (result (ref eq))
                  (local.set $call_result1#37
                   (block (result i32)
                    (local.set $scratch_198
                     (tuple.extract 2 0
                      (local.tee $scratch_197
                       (call $concat_fmt_185
                        (local.get $apply_arg_241)
                        (local.get $P_fmt2_187)
                        (ref.cast (ref $Env)
                         (local.get $apply_funct_242)
                        )
                       )
                      )
                     )
                    )
                    (local.set $call_result2#38
                     (tuple.extract 2 1
                      (local.get $scratch_197)
                     )
                    )
                    (local.get $scratch_198)
                   )
                  )
                  (if (result (ref eq))
                   (local.get $call_result1#37)
                   (then
                    (return
                     (tuple.make 2
                      (i32.const 1)
                      (local.get $call_result2#38)
                     )
                    )
                   )
                   (else
                    (local.get $call_result2#38)
                   )
                  )
                 )
                )
                (local.set $Pmakeblock_arg_244
                 (array.get $Array
                  (ref.cast (ref $Array)
                   (local.get $P_fmt1_188)
                  )
                  (i32.const 3)
                 )
                )
                (local.set $Pmakeblock_arg_245
                 (array.get $Array
                  (ref.cast (ref $Array)
                   (local.get $P_fmt1_188)
                  )
                  (i32.const 2)
                 )
                )
                (local.set $Pmakeblock_arg_246
                 (array.get $Array
                  (ref.cast (ref $Array)
                   (local.get $P_fmt1_188)
                  )
                  (i32.const 1)
                 )
                )
                (array.new_fixed $Array 5
                 (ref.i31
                  (i32.const 6)
                 )
                 (local.get $Pmakeblock_arg_246)
                 (local.get $Pmakeblock_arg_245)
                 (local.get $Pmakeblock_arg_244)
                 (local.get $Pmakeblock_arg_243)
                )
               )
              )
             )
             (br $switch_result_28
              (block (result (ref (exact $Array)))
               (local.set $apply_arg_230
                (array.get $Array
                 (ref.cast (ref $Array)
                  (local.get $P_fmt1_188)
                 )
                 (i32.const 4)
                )
               )
               (local.set $apply_funct_231
                (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
               )
               (local.set $Pmakeblock_arg_232
                (block (result (ref eq))
                 (local.set $call_result1#39
                  (block (result i32)
                   (local.set $scratch_200
                    (tuple.extract 2 0
                     (local.tee $scratch_199
                      (call $concat_fmt_185
                       (local.get $apply_arg_230)
                       (local.get $P_fmt2_187)
                       (ref.cast (ref $Env)
                        (local.get $apply_funct_231)
                       )
                      )
                     )
                    )
                   )
                   (local.set $call_result2#40
                    (tuple.extract 2 1
                     (local.get $scratch_199)
                    )
                   )
                   (local.get $scratch_200)
                  )
                 )
                 (if (result (ref eq))
                  (local.get $call_result1#39)
                  (then
                   (return
                    (tuple.make 2
                     (i32.const 1)
                     (local.get $call_result2#40)
                    )
                   )
                  )
                  (else
                   (local.get $call_result2#40)
                  )
                 )
                )
               )
               (local.set $Pmakeblock_arg_233
                (array.get $Array
                 (ref.cast (ref $Array)
                  (local.get $P_fmt1_188)
                 )
                 (i32.const 3)
                )
               )
               (local.set $Pmakeblock_arg_234
                (array.get $Array
                 (ref.cast (ref $Array)
                  (local.get $P_fmt1_188)
                 )
                 (i32.const 2)
                )
               )
               (local.set $Pmakeblock_arg_235
                (array.get $Array
                 (ref.cast (ref $Array)
                  (local.get $P_fmt1_188)
                 )
                 (i32.const 1)
                )
               )
               (array.new_fixed $Array 5
                (ref.i31
                 (i32.const 5)
                )
                (local.get $Pmakeblock_arg_235)
                (local.get $Pmakeblock_arg_234)
                (local.get $Pmakeblock_arg_233)
                (local.get $Pmakeblock_arg_232)
               )
              )
             )
            )
            (br $switch_result_28
             (block (result (ref (exact $Array)))
              (local.set $apply_arg_219
               (array.get $Array
                (ref.cast (ref $Array)
                 (local.get $P_fmt1_188)
                )
                (i32.const 4)
               )
              )
              (local.set $apply_funct_220
               (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
              )
              (local.set $Pmakeblock_arg_221
               (block (result (ref eq))
                (local.set $call_result1#41
                 (block (result i32)
                  (local.set $scratch_202
                   (tuple.extract 2 0
                    (local.tee $scratch_201
                     (call $concat_fmt_185
                      (local.get $apply_arg_219)
                      (local.get $P_fmt2_187)
                      (ref.cast (ref $Env)
                       (local.get $apply_funct_220)
                      )
                     )
                    )
                   )
                  )
                  (local.set $call_result2#42
                   (tuple.extract 2 1
                    (local.get $scratch_201)
                   )
                  )
                  (local.get $scratch_202)
                 )
                )
                (if (result (ref eq))
                 (local.get $call_result1#41)
                 (then
                  (return
                   (tuple.make 2
                    (i32.const 1)
                    (local.get $call_result2#42)
                   )
                  )
                 )
                 (else
                  (local.get $call_result2#42)
                 )
                )
               )
              )
              (local.set $Pmakeblock_arg_222
               (array.get $Array
                (ref.cast (ref $Array)
                 (local.get $P_fmt1_188)
                )
                (i32.const 3)
               )
              )
              (local.set $Pmakeblock_arg_223
               (array.get $Array
                (ref.cast (ref $Array)
                 (local.get $P_fmt1_188)
                )
                (i32.const 2)
               )
              )
              (local.set $Pmakeblock_arg_224
               (array.get $Array
                (ref.cast (ref $Array)
                 (local.get $P_fmt1_188)
                )
                (i32.const 1)
               )
              )
              (array.new_fixed $Array 5
               (ref.i31
                (i32.const 4)
               )
               (local.get $Pmakeblock_arg_224)
               (local.get $Pmakeblock_arg_223)
               (local.get $Pmakeblock_arg_222)
               (local.get $Pmakeblock_arg_221)
              )
             )
            )
           )
           (br $switch_result_28
            (block (result (ref (exact $Array)))
             (local.set $apply_arg_210
              (array.get $Array
               (ref.cast (ref $Array)
                (local.get $P_fmt1_188)
               )
               (i32.const 2)
              )
             )
             (local.set $apply_funct_211
              (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
             )
             (local.set $Pmakeblock_arg_212
              (block (result (ref eq))
               (local.set $call_result1#43
                (block (result i32)
                 (local.set $scratch_204
                  (tuple.extract 2 0
                   (local.tee $scratch_203
                    (call $concat_fmt_185
                     (local.get $apply_arg_210)
                     (local.get $P_fmt2_187)
                     (ref.cast (ref $Env)
                      (local.get $apply_funct_211)
                     )
                    )
                   )
                  )
                 )
                 (local.set $call_result2#44
                  (tuple.extract 2 1
                   (local.get $scratch_203)
                  )
                 )
                 (local.get $scratch_204)
                )
               )
               (if (result (ref eq))
                (local.get $call_result1#43)
                (then
                 (return
                  (tuple.make 2
                   (i32.const 1)
                   (local.get $call_result2#44)
                  )
                 )
                )
                (else
                 (local.get $call_result2#44)
                )
               )
              )
             )
             (local.set $Pmakeblock_arg_213
              (array.get $Array
               (ref.cast (ref $Array)
                (local.get $P_fmt1_188)
               )
               (i32.const 1)
              )
             )
             (array.new_fixed $Array 3
              (ref.i31
               (i32.const 3)
              )
              (local.get $Pmakeblock_arg_213)
              (local.get $Pmakeblock_arg_212)
             )
            )
           )
          )
          (br $switch_result_28
           (block (result (ref (exact $Array)))
            (local.set $apply_arg_203
             (array.get $Array
              (ref.cast (ref $Array)
               (local.get $P_fmt1_188)
              )
              (i32.const 2)
             )
            )
            (local.set $apply_funct_204
             (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
            )
            (local.set $Pmakeblock_arg_205
             (block (result (ref eq))
              (local.set $call_result1#45
               (block (result i32)
                (local.set $scratch_206
                 (tuple.extract 2 0
                  (local.tee $scratch_205
                   (call $concat_fmt_185
                    (local.get $apply_arg_203)
                    (local.get $P_fmt2_187)
                    (ref.cast (ref $Env)
                     (local.get $apply_funct_204)
                    )
                   )
                  )
                 )
                )
                (local.set $call_result2#46
                 (tuple.extract 2 1
                  (local.get $scratch_205)
                 )
                )
                (local.get $scratch_206)
               )
              )
              (if (result (ref eq))
               (local.get $call_result1#45)
               (then
                (return
                 (tuple.make 2
                  (i32.const 1)
                  (local.get $call_result2#46)
                 )
                )
               )
               (else
                (local.get $call_result2#46)
               )
              )
             )
            )
            (local.set $Pmakeblock_arg_206
             (array.get $Array
              (ref.cast (ref $Array)
               (local.get $P_fmt1_188)
              )
              (i32.const 1)
             )
            )
            (array.new_fixed $Array 3
             (ref.i31
              (i32.const 2)
             )
             (local.get $Pmakeblock_arg_206)
             (local.get $Pmakeblock_arg_205)
            )
           )
          )
         )
         (br $switch_result_28
          (block (result (ref (exact $Array)))
           (local.set $apply_arg_197
            (array.get $Array
             (ref.cast (ref $Array)
              (local.get $P_fmt1_188)
             )
             (i32.const 1)
            )
           )
           (local.set $apply_funct_198
            (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
           )
           (local.set $Pmakeblock_arg_199
            (block (result (ref eq))
             (local.set $call_result1#47
              (block (result i32)
               (local.set $scratch_208
                (tuple.extract 2 0
                 (local.tee $scratch_207
                  (call $concat_fmt_185
                   (local.get $apply_arg_197)
                   (local.get $P_fmt2_187)
                   (ref.cast (ref $Env)
                    (local.get $apply_funct_198)
                   )
                  )
                 )
                )
               )
               (local.set $call_result2#48
                (tuple.extract 2 1
                 (local.get $scratch_207)
                )
               )
               (local.get $scratch_208)
              )
             )
             (if (result (ref eq))
              (local.get $call_result1#47)
              (then
               (return
                (tuple.make 2
                 (i32.const 1)
                 (local.get $call_result2#48)
                )
               )
              )
              (else
               (local.get $call_result2#48)
              )
             )
            )
           )
           (array.new_fixed $Array 2
            (ref.i31
             (i32.const 1)
            )
            (local.get $Pmakeblock_arg_199)
           )
          )
         )
        )
        (br $switch_result_28
         (block (result (ref (exact $Array)))
          (local.set $apply_arg_192
           (array.get $Array
            (ref.cast (ref $Array)
             (local.get $P_fmt1_188)
            )
            (i32.const 1)
           )
          )
          (local.set $apply_funct_193
           (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
          )
          (local.set $Pmakeblock_arg_194
           (block (result (ref eq))
            (local.set $call_result1#49
             (block (result i32)
              (local.set $scratch_210
               (tuple.extract 2 0
                (local.tee $scratch_209
                 (call $concat_fmt_185
                  (local.get $apply_arg_192)
                  (local.get $P_fmt2_187)
                  (ref.cast (ref $Env)
                   (local.get $apply_funct_193)
                  )
                 )
                )
               )
              )
              (local.set $call_result2#50
               (tuple.extract 2 1
                (local.get $scratch_209)
               )
              )
              (local.get $scratch_210)
             )
            )
            (if (result (ref eq))
             (local.get $call_result1#49)
             (then
              (return
               (tuple.make 2
                (i32.const 1)
                (local.get $call_result2#50)
               )
              )
             )
             (else
              (local.get $call_result2#50)
             )
            )
           )
          )
          (array.new_fixed $Array 2
           (ref.i31
            (i32.const 0)
           )
           (local.get $Pmakeblock_arg_194)
          )
         )
        )
       )
      )
     )
     (local.get $switch_result#51)
    )
   )
  )
 )
 (func $Caml_curry_3_2 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Gen_closure_3))
  (local $Partial_closure (ref $Partial_closure_3_2))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Partial_closure
     (ref.cast (ref $Partial_closure_3_2)
      (local.get $Env)
     )
    )
    (local.set $Closure
     (struct.get $Partial_closure_3_2 2
      (local.get $Partial_closure)
     )
    )
    (return_call_ref $Func_3
     (struct.get $Partial_closure_3_2 3
      (local.get $Partial_closure)
     )
     (struct.get $Partial_closure_3_2 4
      (local.get $Partial_closure)
     )
     (local.get $P_arg_0)
     (local.get $Closure)
     (struct.get $Gen_closure_3 2
      (local.get $Closure)
     )
    )
   )
  )
 )
 (func $Caml_curry_3_1 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Partial_closure_3_1))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_3_2)))
    (local.set $Closure
     (ref.cast (ref $Partial_closure_3_1)
      (local.get $Env)
     )
    )
    (struct.new $Partial_closure_3_2
     (i32.const 1)
     (ref.func $Caml_curry_3_2)
     (struct.get $Partial_closure_3_1 2
      (local.get $Closure)
     )
     (struct.get $Partial_closure_3_1 3
      (local.get $Closure)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $Caml_curry_3 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_3_1)))
    (struct.new $Partial_closure_3_1
     (i32.const 1)
     (ref.func $Caml_curry_3_1)
     (ref.cast (ref $Gen_closure_3)
      (local.get $Env)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $Caml_curry_2_1_153 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Gen_closure_2))
  (local $Partial_closure (ref $Partial_closure_2_1))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Partial_closure
     (ref.cast (ref $Partial_closure_2_1)
      (local.get $Env)
     )
    )
    (local.set $Closure
     (struct.get $Partial_closure_2_1 2
      (local.get $Partial_closure)
     )
    )
    (return_call_ref $Func_2
     (struct.get $Partial_closure_2_1 3
      (local.get $Partial_closure)
     )
     (local.get $P_arg_0)
     (local.get $Closure)
     (struct.get $Gen_closure_2 2
      (local.get $Closure)
     )
    )
   )
  )
 )
 (func $Caml_curry_2_153 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_2_1)))
    (struct.new $Partial_closure_2_1
     (i32.const 1)
     (ref.func $Caml_curry_2_1_153)
     (ref.cast (ref $Gen_closure_2)
      (local.get $Env)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $R_not_really_start_153 (type $22)
 )
 (func $make_26 (type $Func_1) (param $P_v_28 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Array)))
    (array.new_fixed $Array 2
     (ref.i31
      (i32.const 0)
     )
     (local.get $P_v_28)
    )
   )
  )
 )
 (func $get_33 (type $Func_1) (param $P_r_35 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (array.get $Array
     (ref.cast (ref $Array)
      (local.get $P_r_35)
     )
     (i32.const 1)
    )
   )
  )
 )
 (func $set_40 (type $Func_2) (param $P_r_43 (ref eq)) (param $P_v_42 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref i31))
    (array.set $Array
     (ref.cast (ref $Array)
      (local.get $P_r_43)
     )
     (i32.const 1)
     (local.get $P_v_42)
    )
    (ref.i31
     (i32.const 0)
    )
   )
  )
 )
 (func $exchange_48 (type $Func_2) (param $P_r_51 (ref eq)) (param $P_v_50 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $sequence_55 (ref eq))
  (local $cur_53 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $cur_53
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_r_51)
      )
      (i32.const 1)
     )
    )
    (local.set $sequence_55
     (block (result (ref i31))
      (array.set $Array
       (ref.cast (ref $Array)
        (local.get $P_r_51)
       )
       (i32.const 1)
       (local.get $P_v_50)
      )
      (ref.i31
       (i32.const 0)
      )
     )
    )
    (local.get $cur_53)
   )
  )
 )
 (func $compare_and_set_59 (type $Func_3) (param $P_r_63 (ref eq)) (param $P_seen_62 (ref eq)) (param $P_v_61 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $sequence_70 (ref eq))
  (local $cur_65 (ref eq))
  (local $cond_68 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref i31))
    (local.set $cur_65
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_r_63)
      )
      (i32.const 1)
     )
    )
    (local.set $cond_68
     (ref.i31
      (ref.eq
       (local.get $cur_65)
       (local.get $P_seen_62)
      )
     )
    )
    (if (result (ref i31))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_68)
      )
     )
     (then
      (local.set $sequence_70
       (block (result (ref i31))
        (array.set $Array
         (ref.cast (ref $Array)
          (local.get $P_r_63)
         )
         (i32.const 1)
         (local.get $P_v_61)
        )
        (ref.i31
         (i32.const 0)
        )
       )
      )
      (ref.i31
       (i32.const 1)
      )
     )
     (else
      (ref.i31
       (i32.const 0)
      )
     )
    )
   )
  )
 )
 (func $fetch_and_add_75 (type $Func_2) (param $P_r_78 (ref eq)) (param $P_n_77 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $cur_80 (ref eq))
  (local $Psetfield_arg_84 (ref eq))
  (local $Psetfield_85 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $cur_80
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_r_78)
      )
      (i32.const 1)
     )
    )
    (local.set $Psetfield_arg_84
     (ref.i31
      (i32.add
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $cur_80)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_n_77)
        )
       )
      )
     )
    )
    (local.set $Psetfield_85
     (block (result (ref i31))
      (array.set $Array
       (ref.cast (ref $Array)
        (local.get $P_r_78)
       )
       (i32.const 1)
       (local.get $Psetfield_arg_84)
      )
      (ref.i31
       (i32.const 0)
      )
     )
    )
    (local.get $cur_80)
   )
  )
 )
 (func $incr_88 (type $Func_1) (param $P_r_91 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#4 (ref eq))
  (local $call_result1#3 i32)
  (local $ignore_93 (ref eq))
  (local $apply_funct_96 (ref eq))
  (local $apply_arg_95 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_8 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref i31))
    (local.set $apply_arg_95
     (ref.i31
      (i32.const 1)
     )
    )
    (local.set $apply_funct_96
     (global.get $camlCamlinternalAtomic__fetch_and_add_75_closure)
    )
    (local.set $ignore_93
     (block (result (ref eq))
      (local.set $call_result1#3
       (block (result i32)
        (local.set $scratch_8
         (tuple.extract 2 0
          (local.tee $scratch
           (call $fetch_and_add_75
            (local.get $P_r_91)
            (local.get $apply_arg_95)
            (ref.cast (ref $Env)
             (local.get $apply_funct_96)
            )
           )
          )
         )
        )
        (local.set $call_result2#4
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_8)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#3)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#4)
         )
        )
       )
       (else
        (local.get $call_result2#4)
       )
      )
     )
    )
    (ref.i31
     (i32.const 0)
    )
   )
  )
 )
 (func $decr_100 (type $Func_1) (param $P_r_103 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#2 (ref eq))
  (local $call_result1#1 i32)
  (local $ignore_105 (ref eq))
  (local $apply_funct_108 (ref eq))
  (local $apply_arg_107 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_8 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref i31))
    (local.set $apply_arg_107
     (ref.i31
      (i32.const -1)
     )
    )
    (local.set $apply_funct_108
     (global.get $camlCamlinternalAtomic__fetch_and_add_75_closure)
    )
    (local.set $ignore_105
     (block (result (ref eq))
      (local.set $call_result1#1
       (block (result i32)
        (local.set $scratch_8
         (tuple.extract 2 0
          (local.tee $scratch
           (call $fetch_and_add_75
            (local.get $P_r_103)
            (local.get $apply_arg_107)
            (ref.cast (ref $Env)
             (local.get $apply_funct_108)
            )
           )
          )
         )
        )
        (local.set $call_result2#2
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_8)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#1)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#2)
         )
        )
       )
       (else
        (local.get $call_result2#2)
       )
      )
     )
    )
    (ref.i31
     (i32.const 0)
    )
   )
  )
 )
 (func $merged.start.new (type $22)
  (call $R_not_really_start_153)
 )
 (func $Caml_curry_4_3 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Gen_closure_4))
  (local $Partial_closure (ref $Partial_closure_4_3))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Partial_closure
     (ref.cast (ref $Partial_closure_4_3)
      (local.get $Env)
     )
    )
    (local.set $Closure
     (struct.get $Partial_closure_4_3 2
      (local.get $Partial_closure)
     )
    )
    (return_call_ref $Func_4
     (struct.get $Partial_closure_4_3 3
      (local.get $Partial_closure)
     )
     (struct.get $Partial_closure_4_3 4
      (local.get $Partial_closure)
     )
     (struct.get $Partial_closure_4_3 5
      (local.get $Partial_closure)
     )
     (local.get $P_arg_0)
     (local.get $Closure)
     (struct.get $Gen_closure_4 2
      (local.get $Closure)
     )
    )
   )
  )
 )
 (func $Caml_curry_4_2 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Partial_closure_4_2))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_4_3)))
    (local.set $Closure
     (ref.cast (ref $Partial_closure_4_2)
      (local.get $Env)
     )
    )
    (struct.new $Partial_closure_4_3
     (i32.const 1)
     (ref.func $Caml_curry_4_3)
     (struct.get $Partial_closure_4_2 2
      (local.get $Closure)
     )
     (struct.get $Partial_closure_4_2 3
      (local.get $Closure)
     )
     (struct.get $Partial_closure_4_2 4
      (local.get $Closure)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $Caml_curry_4_1 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Partial_closure_4_1))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_4_2)))
    (local.set $Closure
     (ref.cast (ref $Partial_closure_4_1)
      (local.get $Env)
     )
    )
    (struct.new $Partial_closure_4_2
     (i32.const 1)
     (ref.func $Caml_curry_4_2)
     (struct.get $Partial_closure_4_1 2
      (local.get $Closure)
     )
     (struct.get $Partial_closure_4_1 3
      (local.get $Closure)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $Caml_curry_4 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_4_1)))
    (struct.new $Partial_closure_4_1
     (i32.const 1)
     (ref.func $Caml_curry_4_1)
     (ref.cast (ref $Gen_closure_4)
      (local.get $Env)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $Caml_curry_3_2_170 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Gen_closure_3))
  (local $Partial_closure (ref $Partial_closure_3_2))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Partial_closure
     (ref.cast (ref $Partial_closure_3_2)
      (local.get $Env)
     )
    )
    (local.set $Closure
     (struct.get $Partial_closure_3_2 2
      (local.get $Partial_closure)
     )
    )
    (return_call_ref $Func_3
     (struct.get $Partial_closure_3_2 3
      (local.get $Partial_closure)
     )
     (struct.get $Partial_closure_3_2 4
      (local.get $Partial_closure)
     )
     (local.get $P_arg_0)
     (local.get $Closure)
     (struct.get $Gen_closure_3 2
      (local.get $Closure)
     )
    )
   )
  )
 )
 (func $Caml_curry_3_1_170 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Partial_closure_3_1))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_3_2)))
    (local.set $Closure
     (ref.cast (ref $Partial_closure_3_1)
      (local.get $Env)
     )
    )
    (struct.new $Partial_closure_3_2
     (i32.const 1)
     (ref.func $Caml_curry_3_2_170)
     (struct.get $Partial_closure_3_1 2
      (local.get $Closure)
     )
     (struct.get $Partial_closure_3_1 3
      (local.get $Closure)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $Caml_curry_3_170 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_3_1)))
    (struct.new $Partial_closure_3_1
     (i32.const 1)
     (ref.func $Caml_curry_3_1_170)
     (ref.cast (ref $Gen_closure_3)
      (local.get $Env)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $Caml_curry_2_1_170 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Gen_closure_2))
  (local $Partial_closure (ref $Partial_closure_2_1))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Partial_closure
     (ref.cast (ref $Partial_closure_2_1)
      (local.get $Env)
     )
    )
    (local.set $Closure
     (struct.get $Partial_closure_2_1 2
      (local.get $Partial_closure)
     )
    )
    (return_call_ref $Func_2
     (struct.get $Partial_closure_2_1 3
      (local.get $Partial_closure)
     )
     (local.get $P_arg_0)
     (local.get $Closure)
     (struct.get $Gen_closure_2 2
      (local.get $Closure)
     )
    )
   )
  )
 )
 (func $Caml_curry_2_170 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_2_1)))
    (struct.new $Partial_closure_2_1
     (i32.const 1)
     (ref.func $Caml_curry_2_1_170)
     (ref.cast (ref $Gen_closure_2)
      (local.get $Env)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $R_not_really_start_170 (type $22)
  (local $call_result2#4 (ref eq))
  (local $call_result2#2 (ref eq))
  (local $call_result1#3 i32)
  (local $call_result1#1 i32)
  (local $v_2698 (ref eq))
  (local $success_2728 (ref eq))
  (local $simplify_fv_2701 (ref eq))
  (local $r_2700 (ref eq))
  (local $new_exit_2725 (ref eq))
  (local $new_exit_2724 (ref eq))
  (local $flush_all_1876 (ref eq))
  (local $exit_function_2727 (ref eq))
  (local $do_at_exit_1867 (ref eq))
  (local $cond_2729 (ref eq))
  (local $apply_funct_1490 (ref eq))
  (local $apply_arg_1489 (ref eq))
  (local $Pmakeblock_2699 (ref eq))
  (local $Pfield_2726 (ref eq))
  (local $Pccall_arg_1934 (ref eq))
  (local $Pccall_arg_1933 (ref eq))
  (local $Pccall_arg_1932 (ref eq))
  (local $Pccall_arg_1925 (ref eq))
  (local $Pccall_arg_1924 (ref eq))
  (local $Pccall_arg_1923 (ref eq))
  (local $Pccall_arg_1922 (ref eq))
  (local $Pccall_arg_1921 (ref eq))
  (local $Pccall_arg_1920 (ref eq))
  (local $Pccall_arg_1919 (ref eq))
  (local $Pccall_arg_1918 (ref eq))
  (local $Pccall_arg_1917 (ref eq))
  (local $Pccall_arg_1868 (ref eq))
  (local $Pccall_arg_1866 (ref eq))
  (local $Pccall_1865 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_34 i32)
  (local $scratch_35 (tuple i32 (ref eq)))
  (local $scratch_36 i32)
  (drop
   (block (result (ref eq))
    (local.set $Pccall_arg_1934
     (global.get $camlStdlib__const_immstring_311)
    )
    (local.set $Pccall_arg_1933
     (global.get $camlStdlib__Pmakeblock_1665)
    )
    (call $44
     (local.get $Pccall_arg_1934)
     (local.get $Pccall_arg_1933)
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1862)
   )
   (i32.const 1)
   (block (result (ref eq))
    (local.set $Pccall_arg_1932
     (ref.i31
      (i32.const 0)
     )
    )
    (call $2_23
     (local.get $Pccall_arg_1932)
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pmakeblock_1861)
   )
   (i32.const 2)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1862)
    )
    (i32.const 1)
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1858)
   )
   (i32.const 1)
   (block (result (ref (exact $Float)))
    (local.set $Pccall_arg_1925
     (global.get $camlStdlib__Pccall_arg_2822)
    )
    (struct.new $Float
     (call $1_23
      (struct.get $Int64 0
       (ref.cast (ref $Int64)
        (local.get $Pccall_arg_1925)
       )
      )
     )
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1857)
   )
   (i32.const 1)
   (block (result (ref (exact $Float)))
    (local.set $Pccall_arg_1924
     (global.get $camlStdlib__Pccall_arg_2823)
    )
    (struct.new $Float
     (call $1_23
      (struct.get $Int64 0
       (ref.cast (ref $Int64)
        (local.get $Pccall_arg_1924)
       )
      )
     )
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1856)
   )
   (i32.const 1)
   (block (result (ref (exact $Float)))
    (local.set $Pccall_arg_1923
     (global.get $camlStdlib__Pccall_arg_2824)
    )
    (struct.new $Float
     (call $1_23
      (struct.get $Int64 0
       (ref.cast (ref $Int64)
        (local.get $Pccall_arg_1923)
       )
      )
     )
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1855)
   )
   (i32.const 1)
   (block (result (ref (exact $Float)))
    (local.set $Pccall_arg_1922
     (global.get $camlStdlib__Pccall_arg_2825)
    )
    (struct.new $Float
     (call $1_23
      (struct.get $Int64 0
       (ref.cast (ref $Int64)
        (local.get $Pccall_arg_1922)
       )
      )
     )
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1854)
   )
   (i32.const 1)
   (block (result (ref (exact $Float)))
    (local.set $Pccall_arg_1921
     (global.get $camlStdlib__Pccall_arg_2826)
    )
    (struct.new $Float
     (call $1_23
      (struct.get $Int64 0
       (ref.cast (ref $Int64)
        (local.get $Pccall_arg_1921)
       )
      )
     )
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1853)
   )
   (i32.const 1)
   (block (result (ref (exact $Float)))
    (local.set $Pccall_arg_1920
     (global.get $camlStdlib__Pccall_arg_2827)
    )
    (struct.new $Float
     (call $1_23
      (struct.get $Int64 0
       (ref.cast (ref $Int64)
        (local.get $Pccall_arg_1920)
       )
      )
     )
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1852)
   )
   (i32.const 1)
   (block (result (ref eq))
    (local.set $Pccall_arg_1919
     (ref.i31
      (i32.const 0)
     )
    )
    (call $16
     (local.get $Pccall_arg_1919)
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1851)
   )
   (i32.const 1)
   (block (result (ref eq))
    (local.set $Pccall_arg_1918
     (ref.i31
      (i32.const 1)
     )
    )
    (call $15
     (local.get $Pccall_arg_1918)
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1850)
   )
   (i32.const 1)
   (block (result (ref eq))
    (local.set $Pccall_arg_1917
     (ref.i31
      (i32.const 2)
     )
    )
    (call $15
     (local.get $Pccall_arg_1917)
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__exit_function_1810)
   )
   (i32.const 1)
   (block (result (ref (exact $Array)))
    (local.set $flush_all_1876
     (global.get $camlStdlib__flush_all_715_closure)
    )
    (array.new_fixed $Array 2
     (ref.i31
      (i32.const 0)
     )
     (local.get $flush_all_1876)
    )
   )
  )
  (drop
   (block (result (ref eq))
    (local.set $Pccall_arg_1868
     (global.get $camlStdlib__const_immstring_1473)
    )
    (local.set $do_at_exit_1867
     (global.get $camlStdlib__do_at_exit_1448_closure)
    )
    (call $44
     (local.get $Pccall_arg_1868)
     (local.get $do_at_exit_1867)
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib__Pccall_1802)
   )
   (i32.const 1)
   (block (result (ref eq))
    (local.set $Pccall_arg_1866
     (ref.i31
      (i32.const 0)
     )
    )
    (call $47
     (local.get $Pccall_arg_1866)
    )
   )
  )
  (drop
   (block (result (ref eq))
    (local.set $Pccall_1865
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1802)
      )
      (i32.const 1)
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $Pccall_1865)
      )
     )
     (then
      (local.set $apply_arg_1489
       (global.get $camlStdlib__anon_fn_1483_closure)
      )
      (local.set $apply_funct_1490
       (global.get $camlStdlib__at_exit_1395_closure)
      )
      (local.set $v_2698
       (ref.i31
        (i32.const 1)
       )
      )
      (local.set $Pmakeblock_2699
       (array.new_fixed $Array 2
        (ref.i31
         (i32.const 0)
        )
        (local.get $v_2698)
       )
      )
      (local.set $r_2700
       (array.get $Array
        (ref.cast (ref $Array)
         (global.get $camlStdlib__exit_function_1810)
        )
        (i32.const 1)
       )
      )
      (local.set $simplify_fv_2701
       (array.get $Array
        (ref.cast (ref $Array)
         (local.get $r_2700)
        )
        (i32.const 1)
       )
      )
      (local.set $new_exit_2724
       (struct.new $Closure_1_2
        (i32.const 1)
        (ref.func $new_exit_2705)
        (local.get $Pmakeblock_2699)
        (local.get $simplify_fv_2701)
       )
      )
      (local.set $new_exit_2725
       (local.get $new_exit_2724)
      )
      (local.set $Pfield_2726
       (global.get $camlCamlinternalAtomic__compare_and_set_59_closure)
      )
      (local.set $exit_function_2727
       (array.get $Array
        (ref.cast (ref $Array)
         (global.get $camlStdlib__exit_function_1810)
        )
        (i32.const 1)
       )
      )
      (local.set $success_2728
       (block (result (ref eq))
        (local.set $call_result1#1
         (block (result i32)
          (local.set $scratch_34
           (tuple.extract 2 0
            (local.tee $scratch
             (call $compare_and_set_59
              (local.get $exit_function_2727)
              (local.get $simplify_fv_2701)
              (local.get $new_exit_2725)
              (ref.cast (ref $Env)
               (local.get $Pfield_2726)
              )
             )
            )
           )
          )
          (local.set $call_result2#2
           (tuple.extract 2 1
            (local.get $scratch)
           )
          )
          (local.get $scratch_34)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#1)
         (then
          (unreachable)
         )
         (else
          (local.get $call_result2#2)
         )
        )
       )
      )
      (local.set $cond_2729
       (ref.i31
        (i32.sub
         (i32.const 1)
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $success_2728)
          )
         )
        )
       )
      )
      (if (result (ref eq))
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $cond_2729)
        )
       )
       (then
        (local.set $call_result1#3
         (block (result i32)
          (local.set $scratch_36
           (tuple.extract 2 0
            (local.tee $scratch_35
             (call $at_exit_1395
              (local.get $apply_arg_1489)
              (ref.cast (ref $Env)
               (local.get $apply_funct_1490)
              )
             )
            )
           )
          )
          (local.set $call_result2#4
           (tuple.extract 2 1
            (local.get $scratch_35)
           )
          )
          (local.get $scratch_36)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#3)
         (then
          (unreachable)
         )
         (else
          (local.get $call_result2#4)
         )
        )
       )
       (else
        (ref.i31
         (i32.const 0)
        )
       )
      )
     )
     (else
      (ref.i31
       (i32.const 0)
      )
     )
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib)
   )
   (i32.const 22)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1858)
    )
    (i32.const 1)
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib)
   )
   (i32.const 23)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1857)
    )
    (i32.const 1)
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib)
   )
   (i32.const 24)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1856)
    )
    (i32.const 1)
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib)
   )
   (i32.const 25)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1855)
    )
    (i32.const 1)
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib)
   )
   (i32.const 26)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1854)
    )
    (i32.const 1)
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib)
   )
   (i32.const 27)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1853)
    )
    (i32.const 1)
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib)
   )
   (i32.const 38)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1852)
    )
    (i32.const 1)
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib)
   )
   (i32.const 39)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1851)
    )
    (i32.const 1)
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStdlib)
   )
   (i32.const 40)
   (array.get $Array
    (ref.cast (ref $Array)
     (global.get $camlStdlib__Pccall_1850)
    )
    (i32.const 1)
   )
  )
 )
 (func $failwith_323 (type $Func_1) (param $P_s_325 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Pmakeblock_arg_330 (ref eq))
  (local $Pmakeblock_331 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Pmakeblock_arg_330
     (global.get $global$2)
    )
    (local.set $Pmakeblock_331
     (array.new_fixed $Array 3
      (ref.i31
       (i32.const 0)
      )
      (local.get $Pmakeblock_arg_330)
      (local.get $P_s_325)
     )
    )
    (return
     (tuple.make 2
      (i32.const 1)
      (local.get $Pmakeblock_331)
     )
    )
   )
  )
 )
 (func $invalid_arg_334 (type $Func_1) (param $P_s_336 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Pmakeblock_arg_341 (ref eq))
  (local $Pmakeblock_342 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Pmakeblock_arg_341
     (global.get $invalid_argument)
    )
    (local.set $Pmakeblock_342
     (array.new_fixed $Array 3
      (ref.i31
       (i32.const 0)
      )
      (local.get $Pmakeblock_arg_341)
      (local.get $P_s_336)
     )
    )
    (return
     (tuple.make 2
      (i32.const 1)
      (local.get $Pmakeblock_342)
     )
    )
   )
  )
 )
 (func $min_378 (type $Func_2) (param $P_x_381 (ref eq)) (param $P_y_380 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $cond_384 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $cond_384
     (call $9_23
      (local.get $P_x_381)
      (local.get $P_y_380)
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_384)
      )
     )
     (then
      (local.get $P_x_381)
     )
     (else
      (local.get $P_y_380)
     )
    )
   )
  )
 )
 (func $max_387 (type $Func_2) (param $P_x_390 (ref eq)) (param $P_y_389 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $cond_393 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $cond_393
     (call $10_23
      (local.get $P_x_390)
      (local.get $P_y_389)
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_393)
      )
     )
     (then
      (local.get $P_x_390)
     )
     (else
      (local.get $P_y_389)
     )
    )
   )
  )
 )
 (func $abs_396 (type $Func_1) (param $P_x_398 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Pintcomp_arg_401 (ref eq))
  (local $Pintcomp_402 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pintcomp_arg_401
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_402
     (ref.i31
      (i32.ge_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_x_398)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_arg_401)
        )
       )
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $Pintcomp_402)
      )
     )
     (then
      (local.get $P_x_398)
     )
     (else
      (ref.i31
       (i32.xor
        (i31.get_s
         (ref.cast (ref i31)
          (local.get $P_x_398)
         )
        )
        (i32.const 0)
       )
      )
     )
    )
   )
  )
 )
 (func $lnot_407 (type $Func_1) (param $P_x_409 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Pxorint_arg_412 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref i31))
    (local.set $Pxorint_arg_412
     (ref.i31
      (i32.const -1)
     )
    )
    (ref.i31
     (i32.xor
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $P_x_409)
       )
      )
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $Pxorint_arg_412)
       )
      )
     )
    )
   )
  )
 )
 (func $^_456 (type $Func_2) (param $P_s1_459 (ref eq)) (param $P_s2_458 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $l2_463 (ref eq))
  (local $l1_461 (ref eq))
  (local $Pccall_arg_477 (ref eq))
  (local $Pccall_arg_473 (ref eq))
  (local $Pccall_arg_472 (ref eq))
  (local $Pccall_arg_467 (ref eq))
  (local $Pccall_478 (ref eq))
  (local $Pccall_474 (ref eq))
  (local $Pccall_468 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $l1_461
     (ref.i31
      (array.len
       (ref.cast (ref $String)
        (local.get $P_s1_459)
       )
      )
     )
    )
    (local.set $l2_463
     (ref.i31
      (array.len
       (ref.cast (ref $String)
        (local.get $P_s2_458)
       )
      )
     )
    )
    (local.set $Pccall_arg_467
     (ref.i31
      (i32.add
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $l1_461)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $l2_463)
        )
       )
      )
     )
    )
    (local.set $Pccall_468
     (call $3_23
      (local.get $Pccall_arg_467)
     )
    )
    (local.set $Pccall_arg_472
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pccall_arg_473
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pccall_474
     (call $5_23
      (local.get $P_s1_459)
      (local.get $Pccall_arg_473)
      (local.get $Pccall_468)
      (local.get $Pccall_arg_472)
      (local.get $l1_461)
     )
    )
    (local.set $Pccall_arg_477
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pccall_478
     (call $5_23
      (local.get $P_s2_458)
      (local.get $Pccall_arg_477)
      (local.get $Pccall_468)
      (local.get $l1_461)
      (local.get $l2_463)
     )
    )
    (local.get $Pccall_468)
   )
  )
 )
 (func $char_of_int_481 (type $Func_1) (param $P_n_484 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $cond_494 (ref eq))
  (local $Pmakeblock_2340 (ref eq))
  (local $Pintcomp_arg_490 (ref eq))
  (local $Pintcomp_arg_487 (ref eq))
  (local $Pintcomp_488 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pintcomp_arg_487
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_488
     (ref.i31
      (i32.lt_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_n_484)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_arg_487)
        )
       )
      )
     )
    )
    (local.set $cond_494
     (if (result (ref i31))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $Pintcomp_488)
       )
      )
      (then
       (ref.i31
        (i32.const 1)
       )
      )
      (else
       (local.set $Pintcomp_arg_490
        (ref.i31
         (i32.const 255)
        )
       )
       (ref.i31
        (i32.gt_s
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $P_n_484)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Pintcomp_arg_490)
          )
         )
        )
       )
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_494)
      )
     )
     (then
      (local.set $Pmakeblock_2340
       (global.get $camlStdlib__Pmakeblock_2452)
      )
      (return
       (tuple.make 2
        (i32.const 1)
        (local.get $Pmakeblock_2340)
       )
      )
     )
     (else
      (local.get $P_n_484)
     )
    )
   )
  )
 )
 (func $string_of_bool_501 (type $Func_1) (param $P_b_503 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref $String))
    (if (result (ref $String))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $P_b_503)
      )
     )
     (then
      (global.get $camlStdlib__const_immstring_508)
     )
     (else
      (global.get $camlStdlib__const_immstring_506)
     )
    )
   )
  )
 )
 (func $bool_of_string_512 (type $Func_1) (param $P_param_515 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $str#42 (ref $String))
  (local $Pmakeblock_2347 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref i31))
    (block $!catch_12 (result (ref i31))
     (block $catch_12
      (br $!catch_12
       (block (result (ref i31))
        (local.set $str#42
         (ref.cast (ref $String)
          (local.get $P_param_515)
         )
        )
        (if (result (ref i31))
         (i31.get_s
          (ref.cast (ref i31)
           (call $8
            (local.get $str#42)
            (array.new_fixed $String 4
             (i32.const 116)
             (i32.const 114)
             (i32.const 117)
             (i32.const 101)
            )
           )
          )
         )
         (then
          (ref.i31
           (i32.const 1)
          )
         )
         (else
          (if (result (ref i31))
           (i31.get_s
            (ref.cast (ref i31)
             (call $8
              (local.get $str#42)
              (array.new_fixed $String 5
               (i32.const 102)
               (i32.const 97)
               (i32.const 108)
               (i32.const 115)
               (i32.const 101)
              )
             )
            )
           )
           (then
            (ref.i31
             (i32.const 0)
            )
           )
           (else
            (br $catch_12)
            (br $catch_12)
           )
          )
         )
        )
       )
      )
     )
     (local.set $Pmakeblock_2347
      (global.get $camlStdlib__Pmakeblock_2453)
     )
     (return
      (tuple.make 2
       (i32.const 1)
       (local.get $Pmakeblock_2347)
      )
     )
    )
   )
  )
 )
 (func $bool_of_string_opt_526 (type $Func_1) (param $P_param_528 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $str#41 (ref $String))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (block $!catch_11 (result (ref eq))
     (block $catch_11
      (br $!catch_11
       (block (result (ref $Array))
        (local.set $str#41
         (ref.cast (ref $String)
          (local.get $P_param_528)
         )
        )
        (if (result (ref $Array))
         (i31.get_s
          (ref.cast (ref i31)
           (call $8
            (local.get $str#41)
            (array.new_fixed $String 4
             (i32.const 116)
             (i32.const 114)
             (i32.const 117)
             (i32.const 101)
            )
           )
          )
         )
         (then
          (global.get $camlStdlib__const_block_534)
         )
         (else
          (if (result (ref $Array))
           (i31.get_s
            (ref.cast (ref i31)
             (call $8
              (local.get $str#41)
              (array.new_fixed $String 5
               (i32.const 102)
               (i32.const 97)
               (i32.const 108)
               (i32.const 115)
               (i32.const 101)
              )
             )
            )
           )
           (then
            (global.get $camlStdlib__const_block_532)
           )
           (else
            (br $catch_11)
            (br $catch_11)
           )
          )
         )
        )
       )
      )
     )
     (ref.i31
      (i32.const 0)
     )
    )
   )
  )
 )
 (func $string_of_int_538 (type $Func_1) (param $P_n_540 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Pccall_arg_544 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pccall_arg_544
     (global.get $camlStdlib__const_immstring_542)
    )
    (call $11_23
     (local.get $Pccall_arg_544)
     (local.get $P_n_540)
    )
   )
  )
 )
 (func $int_of_string_opt_548 (type $Func_1) (param $P_s_551 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $exn_553 (ref eq))
  (local $Pmakeblock_arg_562 (ref eq))
  (local $Pintcomp_arg_555 (ref eq))
  (local $Pintcomp_556 (ref eq))
  (local $Failure_1733 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Failure_1733
     (global.get $global$2)
    )
    (block $!exception_handler_10 (result (ref eq))
     (local.tee $exn_553
      (block $exception_handler_10
       (br $!exception_handler_10
        (block (result (ref (exact $Array)))
         (local.set $Pmakeblock_arg_562
          (call $13
           (local.get $P_s_551)
          )
         )
         (array.new_fixed $Array 2
          (ref.i31
           (i32.const 0)
          )
          (local.get $Pmakeblock_arg_562)
         )
        )
       )
      )
     )
     (local.set $Pintcomp_arg_555
      (array.get $Array
       (ref.cast (ref $Array)
        (local.get $exn_553)
       )
       (i32.const 1)
      )
     )
     (local.set $Pintcomp_556
      (ref.i31
       (ref.eq
        (local.get $Pintcomp_arg_555)
        (local.get $Failure_1733)
       )
      )
     )
     (if (result (ref i31))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $Pintcomp_556)
       )
      )
      (then
       (ref.i31
        (i32.const 0)
       )
      )
      (else
       (return
        (tuple.make 2
         (i32.const 1)
         (local.get $exn_553)
        )
       )
      )
     )
    )
   )
  )
 )
 (func $valid_float_lexem_566 (type $Func_1) (param $P_s_569 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $set_of_closures_575 (ref eq))
  (local $loop_573 (ref eq))
  (local $l_571 (ref eq))
  (local $i_2475 (ref eq))
  (local $cond_2476 (ref eq))
  (local $apply_funct_2478 (ref eq))
  (local $apply_arg_2477 (ref eq))
  (local $Pintcomp_arg_2484 (ref eq))
  (local $Pintcomp_arg_2482 (ref eq))
  (local $Pintcomp_arg_2480 (ref eq))
  (local $Pintcomp_2485 (ref eq))
  (local $Pintcomp_2483 (ref eq))
  (local $Pintcomp_2481 (ref eq))
  (local $Paddint_2487 (ref eq))
  (local $*match*_2479 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $l_571
     (ref.i31
      (array.len
       (ref.cast (ref $String)
        (local.get $P_s_569)
       )
      )
     )
    )
    (local.set $set_of_closures_575
     (struct.new $Closure_1_2
      (i32.const 1)
      (ref.func $loop_574)
      (local.get $P_s_569)
      (local.get $l_571)
     )
    )
    (local.set $loop_573
     (local.get $set_of_closures_575)
    )
    (local.set $i_2475
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $cond_2476
     (ref.i31
      (i32.ge_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $i_2475)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $l_571)
        )
       )
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_2476)
      )
     )
     (then
      (local.set $apply_arg_2477
       (global.get $camlStdlib__const_immstring_602)
      )
      (local.set $apply_funct_2478
       (global.get $camlStdlib__^_456_closure)
      )
      (return_call $^_456
       (local.get $P_s_569)
       (local.get $apply_arg_2477)
       (ref.cast (ref $Env)
        (local.get $apply_funct_2478)
       )
      )
     )
     (else
      (local.set $*match*_2479
       (call $7
        (local.get $P_s_569)
        (local.get $i_2475)
       )
      )
      (local.set $Pintcomp_arg_2480
       (ref.i31
        (i32.const 48)
       )
      )
      (local.set $Pintcomp_2481
       (ref.i31
        (i32.ge_s
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $*match*_2479)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Pintcomp_arg_2480)
          )
         )
        )
       )
      )
      (block $!catch_8 (result (ref eq))
       (block $catch_8
        (br $!catch_8
         (block $!catch_9 (result (ref eq))
          (block $catch_9
           (if
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $Pintcomp_2481)
             )
            )
            (then
             (local.set $Pintcomp_arg_2482
              (ref.i31
               (i32.const 58)
              )
             )
             (local.set $Pintcomp_2483
              (ref.i31
               (i32.ge_s
                (i31.get_s
                 (ref.cast (ref i31)
                  (local.get $*match*_2479)
                 )
                )
                (i31.get_s
                 (ref.cast (ref i31)
                  (local.get $Pintcomp_arg_2482)
                 )
                )
               )
              )
             )
             (if
              (i31.get_s
               (ref.cast (ref i31)
                (local.get $Pintcomp_2483)
               )
              )
              (then
               (br $catch_9)
               (br $catch_9)
              )
              (else
               (br $catch_8)
               (br $catch_8)
              )
             )
            )
            (else
             (local.set $Pintcomp_arg_2484
              (ref.i31
               (i32.const 45)
              )
             )
             (local.set $Pintcomp_2485
              (ref.i31
               (i32.sub
                (i32.const 1)
                (ref.eq
                 (local.get $*match*_2479)
                 (local.get $Pintcomp_arg_2484)
                )
               )
              )
             )
             (if
              (i31.get_s
               (ref.cast (ref i31)
                (local.get $Pintcomp_2485)
               )
              )
              (then
               (br $catch_9)
               (br $catch_9)
              )
              (else
               (br $catch_8)
               (br $catch_8)
              )
             )
            )
           )
          )
          (local.get $P_s_569)
         )
        )
       )
       (local.set $Paddint_2487
        (ref.i31
         (i32.const 1)
        )
       )
       (return_call $loop_574
        (local.get $Paddint_2487)
        (ref.cast (ref $Env)
         (local.get $loop_573)
        )
       )
      )
     )
    )
   )
  )
 )
 (func $loop_574 (type $Func_1) (param $P_i_579 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $cond_582 (ref eq))
  (local $apply_funct_605 (ref eq))
  (local $apply_arg_604 (ref eq))
  (local $Pintcomp_arg_599 (ref eq))
  (local $Pintcomp_arg_595 (ref eq))
  (local $Pintcomp_arg_591 (ref eq))
  (local $Pintcomp_600 (ref eq))
  (local $Pintcomp_596 (ref eq))
  (local $Pintcomp_592 (ref eq))
  (local $Paddint_arg_586 (ref eq))
  (local $Paddint_587 (ref eq))
  (local $*match*_583 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $cond_582
     (ref.i31
      (i32.ge_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_i_579)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (struct.get $Closure_1_2 3
          (ref.cast (ref $Closure_1_2)
           (local.get $Env)
          )
         )
        )
       )
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_582)
      )
     )
     (then
      (local.set $apply_arg_604
       (global.get $camlStdlib__const_immstring_602)
      )
      (local.set $apply_funct_605
       (global.get $camlStdlib__^_456_closure)
      )
      (return_call $^_456
       (struct.get $Closure_1_2 2
        (ref.cast (ref $Closure_1_2)
         (local.get $Env)
        )
       )
       (local.get $apply_arg_604)
       (ref.cast (ref $Env)
        (local.get $apply_funct_605)
       )
      )
     )
     (else
      (local.set $*match*_583
       (call $7
        (struct.get $Closure_1_2 2
         (ref.cast (ref $Closure_1_2)
          (local.get $Env)
         )
        )
        (local.get $P_i_579)
       )
      )
      (local.set $Pintcomp_arg_591
       (ref.i31
        (i32.const 48)
       )
      )
      (local.set $Pintcomp_592
       (ref.i31
        (i32.ge_s
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $*match*_583)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Pintcomp_arg_591)
          )
         )
        )
       )
      )
      (block $!catch_6 (result (ref eq))
       (block $catch_6
        (br $!catch_6
         (block $!catch_7 (result (ref eq))
          (block $catch_7
           (if
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $Pintcomp_592)
             )
            )
            (then
             (local.set $Pintcomp_arg_599
              (ref.i31
               (i32.const 58)
              )
             )
             (local.set $Pintcomp_600
              (ref.i31
               (i32.ge_s
                (i31.get_s
                 (ref.cast (ref i31)
                  (local.get $*match*_583)
                 )
                )
                (i31.get_s
                 (ref.cast (ref i31)
                  (local.get $Pintcomp_arg_599)
                 )
                )
               )
              )
             )
             (if
              (i31.get_s
               (ref.cast (ref i31)
                (local.get $Pintcomp_600)
               )
              )
              (then
               (br $catch_7)
               (br $catch_7)
              )
              (else
               (br $catch_6)
               (br $catch_6)
              )
             )
            )
            (else
             (local.set $Pintcomp_arg_595
              (ref.i31
               (i32.const 45)
              )
             )
             (local.set $Pintcomp_596
              (ref.i31
               (i32.sub
                (i32.const 1)
                (ref.eq
                 (local.get $*match*_583)
                 (local.get $Pintcomp_arg_595)
                )
               )
              )
             )
             (if
              (i31.get_s
               (ref.cast (ref i31)
                (local.get $Pintcomp_596)
               )
              )
              (then
               (br $catch_7)
               (br $catch_7)
              )
              (else
               (br $catch_6)
               (br $catch_6)
              )
             )
            )
           )
          )
          (struct.get $Closure_1_2 2
           (ref.cast (ref $Closure_1_2)
            (local.get $Env)
           )
          )
         )
        )
       )
       (local.set $Paddint_arg_586
        (ref.i31
         (i32.const 1)
        )
       )
       (local.set $Paddint_587
        (ref.i31
         (i32.add
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $P_i_579)
           )
          )
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $Paddint_arg_586)
           )
          )
         )
        )
       )
       (return_call $loop_574
        (local.get $Paddint_587)
        (ref.cast (ref $Env)
         (local.get $Env)
        )
       )
      )
     )
    )
   )
  )
 )
 (func $string_of_float_611 (type $Func_1) (param $P_f_614 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $apply_funct_621 (ref eq))
  (local $Pccall_arg_618 (ref eq))
  (local $Pccall_619 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Pccall_arg_618
     (global.get $camlStdlib__const_immstring_616)
    )
    (local.set $Pccall_619
     (call $12_23
      (local.get $Pccall_arg_618)
      (local.get $P_f_614)
     )
    )
    (local.set $apply_funct_621
     (global.get $camlStdlib__valid_float_lexem_566_closure)
    )
    (return_call $valid_float_lexem_566
     (local.get $Pccall_619)
     (ref.cast (ref $Env)
      (local.get $apply_funct_621)
     )
    )
   )
  )
 )
 (func $float_of_string_opt_624 (type $Func_1) (param $P_s_627 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $exn_629 (ref eq))
  (local $Pmakeblock_arg_638 (ref eq))
  (local $Pintcomp_arg_631 (ref eq))
  (local $Pintcomp_632 (ref eq))
  (local $Failure_1735 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Failure_1735
     (global.get $global$2)
    )
    (block $!exception_handler_5 (result (ref eq))
     (local.tee $exn_629
      (block $exception_handler_5
       (br $!exception_handler_5
        (block (result (ref (exact $Array)))
         (local.set $Pmakeblock_arg_638
          (call $14
           (local.get $P_s_627)
          )
         )
         (array.new_fixed $Array 2
          (ref.i31
           (i32.const 0)
          )
          (local.get $Pmakeblock_arg_638)
         )
        )
       )
      )
     )
     (local.set $Pintcomp_arg_631
      (array.get $Array
       (ref.cast (ref $Array)
        (local.get $exn_629)
       )
       (i32.const 1)
      )
     )
     (local.set $Pintcomp_632
      (ref.i31
       (ref.eq
        (local.get $Pintcomp_arg_631)
        (local.get $Failure_1735)
       )
      )
     )
     (if (result (ref i31))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $Pintcomp_632)
       )
      )
      (then
       (ref.i31
        (i32.const 0)
       )
      )
      (else
       (return
        (tuple.make 2
         (i32.const 1)
         (local.get $exn_629)
        )
       )
      )
     )
    )
   )
  )
 )
 (func $__642 (type $Func_2) (param $P_l1_645 (ref eq)) (param $P_l2_644 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#40 (ref eq))
  (local $call_result1#39 i32)
  (local $cond_648 (ref eq))
  (local $apply_funct_652 (ref eq))
  (local $apply_arg_651 (ref eq))
  (local $Pmakeblock_arg_654 (ref eq))
  (local $Pmakeblock_arg_653 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_11 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $cond_648
     (ref.i31
      (ref.test (ref i31)
       (local.get $P_l1_645)
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_648)
      )
     )
     (then
      (local.get $P_l2_644)
     )
     (else
      (local.set $apply_arg_651
       (array.get $Array
        (ref.cast (ref $Array)
         (local.get $P_l1_645)
        )
        (i32.const 2)
       )
      )
      (local.set $apply_funct_652
       (global.get $camlStdlib____642_closure)
      )
      (local.set $Pmakeblock_arg_653
       (block (result (ref eq))
        (local.set $call_result1#39
         (block (result i32)
          (local.set $scratch_11
           (tuple.extract 2 0
            (local.tee $scratch
             (call $__642
              (local.get $apply_arg_651)
              (local.get $P_l2_644)
              (ref.cast (ref $Env)
               (local.get $apply_funct_652)
              )
             )
            )
           )
          )
          (local.set $call_result2#40
           (tuple.extract 2 1
            (local.get $scratch)
           )
          )
          (local.get $scratch_11)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#39)
         (then
          (return
           (tuple.make 2
            (i32.const 1)
            (local.get $call_result2#40)
           )
          )
         )
         (else
          (local.get $call_result2#40)
         )
        )
       )
      )
      (local.set $Pmakeblock_arg_654
       (array.get $Array
        (ref.cast (ref $Array)
         (local.get $P_l1_645)
        )
        (i32.const 1)
       )
      )
      (array.new_fixed $Array 3
       (ref.i31
        (i32.const 0)
       )
       (local.get $Pmakeblock_arg_654)
       (local.get $Pmakeblock_arg_653)
      )
     )
    )
   )
  )
 )
 (func $open_out_gen_669 (type $Func_3) (param $P_mode_673 (ref eq)) (param $P_perm_672 (ref eq)) (param $P_name_671 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $sequence_679 (ref eq))
  (local $Pccall_arg_677 (ref eq))
  (local $Pccall_678 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pccall_arg_677
     (call $17
      (local.get $P_name_671)
      (local.get $P_mode_673)
      (local.get $P_perm_672)
     )
    )
    (local.set $Pccall_678
     (call $15
      (local.get $Pccall_arg_677)
     )
    )
    (local.set $sequence_679
     (call $42
      (local.get $Pccall_678)
      (local.get $P_name_671)
     )
    )
    (local.get $Pccall_678)
   )
  )
 )
 (func $open_out_683 (type $Func_1) (param $P_name_686 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $apply_funct_696 (ref eq))
  (local $apply_arg_695 (ref eq))
  (local $apply_arg_694 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_arg_694
     (ref.i31
      (i32.const 438)
     )
    )
    (local.set $apply_arg_695
     (global.get $camlStdlib__const_block_691)
    )
    (local.set $apply_funct_696
     (global.get $camlStdlib__open_out_gen_669_closure)
    )
    (return_call $open_out_gen_669
     (local.get $apply_arg_695)
     (local.get $apply_arg_694)
     (local.get $P_name_686)
     (ref.cast (ref $Env)
      (local.get $apply_funct_696)
     )
    )
   )
  )
 )
 (func $open_out_bin_699 (type $Func_1) (param $P_name_702 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $apply_funct_712 (ref eq))
  (local $apply_arg_711 (ref eq))
  (local $apply_arg_710 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_arg_710
     (ref.i31
      (i32.const 438)
     )
    )
    (local.set $apply_arg_711
     (global.get $camlStdlib__const_block_707)
    )
    (local.set $apply_funct_712
     (global.get $camlStdlib__open_out_gen_669_closure)
    )
    (return_call $open_out_gen_669
     (local.get $apply_arg_711)
     (local.get $apply_arg_710)
     (local.get $P_name_702)
     (ref.cast (ref $Env)
      (local.get $apply_funct_712)
     )
    )
   )
  )
 )
 (func $iter_721 (type $Func_1) (param $P_param_724 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $sequence_728 (ref eq))
  (local $exn_729 (ref eq))
  (local $cond_727 (ref eq))
  (local $apply_funct_742 (ref eq))
  (local $apply_arg_741 (ref eq))
  (local $Sys_error_1736 (ref eq))
  (local $Pintcomp_arg_731 (ref eq))
  (local $Pintcomp_732 (ref eq))
  (local $Pccall_arg_738 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref i31))
    (local.set $Sys_error_1736
     (global.get $global$6)
    )
    (local.set $cond_727
     (ref.i31
      (ref.test (ref i31)
       (local.get $P_param_724)
      )
     )
    )
    (if (result (ref i31))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_727)
      )
     )
     (then
      (ref.i31
       (i32.const 0)
      )
     )
     (else
      (local.set $sequence_728
       (block $!exception_handler_4 (result (ref eq))
        (local.tee $exn_729
         (block $exception_handler_4
          (br $!exception_handler_4
           (block (result (ref eq))
            (local.set $Pccall_arg_738
             (array.get $Array
              (ref.cast (ref $Array)
               (local.get $P_param_724)
              )
              (i32.const 1)
             )
            )
            (call $18
             (local.get $Pccall_arg_738)
            )
           )
          )
         )
        )
        (local.set $Pintcomp_arg_731
         (array.get $Array
          (ref.cast (ref $Array)
           (local.get $exn_729)
          )
          (i32.const 1)
         )
        )
        (local.set $Pintcomp_732
         (ref.i31
          (ref.eq
           (local.get $Pintcomp_arg_731)
           (local.get $Sys_error_1736)
          )
         )
        )
        (if (result (ref i31))
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Pintcomp_732)
          )
         )
         (then
          (ref.i31
           (i32.const 0)
          )
         )
         (else
          (return
           (tuple.make 2
            (i32.const 1)
            (local.get $exn_729)
           )
          )
         )
        )
       )
      )
      (local.set $apply_arg_741
       (array.get $Array
        (ref.cast (ref $Array)
         (local.get $P_param_724)
        )
        (i32.const 2)
       )
      )
      (local.set $apply_funct_742
       (global.get $camlStdlib__iter_721_closure)
      )
      (return_call $iter_721
       (local.get $apply_arg_741)
       (ref.cast (ref $Env)
        (local.get $apply_funct_742)
       )
      )
     )
    )
   )
  )
 )
 (func $flush_all_715 (type $Func_1) (param $P_param_718 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $apply_funct_748 (ref eq))
  (local $Pccall_arg_745 (ref eq))
  (local $Pccall_746 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Pccall_arg_745
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pccall_746
     (call $19
      (local.get $Pccall_arg_745)
     )
    )
    (local.set $apply_funct_748
     (global.get $camlStdlib__iter_721_closure)
    )
    (return_call $iter_721
     (local.get $Pccall_746)
     (ref.cast (ref $Env)
      (local.get $apply_funct_748)
     )
    )
   )
  )
 )
 (func $output_bytes_751 (type $Func_2) (param $P_oc_754 (ref eq)) (param $P_s_753 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Pccall_arg_759 (ref eq))
  (local $Pccall_arg_758 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pccall_arg_758
     (ref.i31
      (array.len
       (ref.cast (ref $String)
        (local.get $P_s_753)
       )
      )
     )
    )
    (local.set $Pccall_arg_759
     (ref.i31
      (i32.const 0)
     )
    )
    (call $20
     (local.get $P_oc_754)
     (local.get $P_s_753)
     (local.get $Pccall_arg_759)
     (local.get $Pccall_arg_758)
    )
   )
  )
 )
 (func $output_string_763 (type $Func_2) (param $P_oc_766 (ref eq)) (param $P_s_765 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Pccall_arg_771 (ref eq))
  (local $Pccall_arg_770 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pccall_arg_770
     (ref.i31
      (array.len
       (ref.cast (ref $String)
        (local.get $P_s_765)
       )
      )
     )
    )
    (local.set $Pccall_arg_771
     (ref.i31
      (i32.const 0)
     )
    )
    (call $caml_ml_output
     (local.get $P_oc_766)
     (local.get $P_s_765)
     (local.get $Pccall_arg_771)
     (local.get $Pccall_arg_770)
    )
   )
  )
 )
 (func $output_775 (type $Func_4) (param $P_oc_781 (ref eq)) (param $P_s_780 (ref eq)) (param $P_ofs_779 (ref eq)) (param $P_len_778 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $cond_798 (ref eq))
  (local $Psubint_arg_790 (ref eq))
  (local $Psubint_791 (ref eq))
  (local $Pmakeblock_2242 (ref eq))
  (local $Pintcomp_arg_787 (ref eq))
  (local $Pintcomp_arg_784 (ref eq))
  (local $Pintcomp_788 (ref eq))
  (local $Pintcomp_785 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pintcomp_arg_784
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_785
     (ref.i31
      (i32.lt_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_ofs_779)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_arg_784)
        )
       )
      )
     )
    )
    (local.set $cond_798
     (if (result (ref i31))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $Pintcomp_785)
       )
      )
      (then
       (ref.i31
        (i32.const 1)
       )
      )
      (else
       (local.set $Pintcomp_arg_787
        (ref.i31
         (i32.const 0)
        )
       )
       (local.set $Pintcomp_788
        (ref.i31
         (i32.lt_s
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $P_len_778)
           )
          )
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $Pintcomp_arg_787)
           )
          )
         )
        )
       )
       (if (result (ref i31))
        (i31.get_s
         (ref.cast (ref i31)
          (local.get $Pintcomp_788)
         )
        )
        (then
         (ref.i31
          (i32.const 1)
         )
        )
        (else
         (local.set $Psubint_arg_790
          (ref.i31
           (array.len
            (ref.cast (ref $String)
             (local.get $P_s_780)
            )
           )
          )
         )
         (local.set $Psubint_791
          (ref.i31
           (i32.sub
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $Psubint_arg_790)
             )
            )
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $P_len_778)
             )
            )
           )
          )
         )
         (ref.i31
          (i32.gt_s
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $P_ofs_779)
            )
           )
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $Psubint_791)
            )
           )
          )
         )
        )
       )
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_798)
      )
     )
     (then
      (local.set $Pmakeblock_2242
       (global.get $camlStdlib__Pmakeblock_2443)
      )
      (return
       (tuple.make 2
        (i32.const 1)
        (local.get $Pmakeblock_2242)
       )
      )
     )
     (else
      (call $20
       (local.get $P_oc_781)
       (local.get $P_s_780)
       (local.get $P_ofs_779)
       (local.get $P_len_778)
      )
     )
    )
   )
  )
 )
 (func $output_substring_806 (type $Func_4) (param $P_oc_812 (ref eq)) (param $P_s_811 (ref eq)) (param $P_ofs_810 (ref eq)) (param $P_len_809 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $cond_829 (ref eq))
  (local $Psubint_arg_821 (ref eq))
  (local $Psubint_822 (ref eq))
  (local $Pmakeblock_2360 (ref eq))
  (local $Pintcomp_arg_818 (ref eq))
  (local $Pintcomp_arg_815 (ref eq))
  (local $Pintcomp_819 (ref eq))
  (local $Pintcomp_816 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pintcomp_arg_815
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_816
     (ref.i31
      (i32.lt_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_ofs_810)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_arg_815)
        )
       )
      )
     )
    )
    (local.set $cond_829
     (if (result (ref i31))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $Pintcomp_816)
       )
      )
      (then
       (ref.i31
        (i32.const 1)
       )
      )
      (else
       (local.set $Pintcomp_arg_818
        (ref.i31
         (i32.const 0)
        )
       )
       (local.set $Pintcomp_819
        (ref.i31
         (i32.lt_s
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $P_len_809)
           )
          )
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $Pintcomp_arg_818)
           )
          )
         )
        )
       )
       (if (result (ref i31))
        (i31.get_s
         (ref.cast (ref i31)
          (local.get $Pintcomp_819)
         )
        )
        (then
         (ref.i31
          (i32.const 1)
         )
        )
        (else
         (local.set $Psubint_arg_821
          (ref.i31
           (array.len
            (ref.cast (ref $String)
             (local.get $P_s_811)
            )
           )
          )
         )
         (local.set $Psubint_822
          (ref.i31
           (i32.sub
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $Psubint_arg_821)
             )
            )
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $P_len_809)
             )
            )
           )
          )
         )
         (ref.i31
          (i32.gt_s
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $P_ofs_810)
            )
           )
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $Psubint_822)
            )
           )
          )
         )
        )
       )
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_829)
      )
     )
     (then
      (local.set $Pmakeblock_2360
       (global.get $camlStdlib__Pmakeblock_2454)
      )
      (return
       (tuple.make 2
        (i32.const 1)
        (local.get $Pmakeblock_2360)
       )
      )
     )
     (else
      (call $caml_ml_output
       (local.get $P_oc_812)
       (local.get $P_s_811)
       (local.get $P_ofs_810)
       (local.get $P_len_809)
      )
     )
    )
   )
  )
 )
 (func $output_value_837 (type $Func_2) (param $P_chan_840 (ref eq)) (param $P_v_839 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Pccall_arg_843 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pccall_arg_843
     (ref.i31
      (i32.const 0)
     )
    )
    (call $24
     (local.get $P_chan_840)
     (local.get $P_v_839)
     (local.get $Pccall_arg_843)
    )
   )
  )
 )
 (func $close_out_847 (type $Func_1) (param $P_oc_849 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $sequence_851 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $sequence_851
     (call $18
      (local.get $P_oc_849)
     )
    )
    (call $38
     (local.get $P_oc_849)
    )
   )
  )
 )
 (func $close_out_noerr_856 (type $Func_1) (param $P_oc_858 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $sequence_860 (ref eq))
  (local $exn_864 (ref eq))
  (local $exn_861 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $sequence_860
     (block $!exception_handler_2 (result (ref eq))
      (local.tee $exn_861
       (block $exception_handler_2
        (br $!exception_handler_2
         (call $18
          (local.get $P_oc_858)
         )
        )
       )
      )
      (ref.i31
       (i32.const 0)
      )
     )
    )
    (block $!exception_handler_3 (result (ref eq))
     (local.tee $exn_864
      (block $exception_handler_3
       (br $!exception_handler_3
        (call $38
         (local.get $P_oc_858)
        )
       )
      )
     )
     (ref.i31
      (i32.const 0)
     )
    )
   )
  )
 )
 (func $open_in_gen_869 (type $Func_3) (param $P_mode_873 (ref eq)) (param $P_perm_872 (ref eq)) (param $P_name_871 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $sequence_879 (ref eq))
  (local $Pccall_arg_877 (ref eq))
  (local $Pccall_878 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pccall_arg_877
     (call $17
      (local.get $P_name_871)
      (local.get $P_mode_873)
      (local.get $P_perm_872)
     )
    )
    (local.set $Pccall_878
     (call $16
      (local.get $Pccall_arg_877)
     )
    )
    (local.set $sequence_879
     (call $42
      (local.get $Pccall_878)
      (local.get $P_name_871)
     )
    )
    (local.get $Pccall_878)
   )
  )
 )
 (func $open_in_883 (type $Func_1) (param $P_name_886 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $apply_funct_894 (ref eq))
  (local $apply_arg_893 (ref eq))
  (local $apply_arg_892 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_arg_892
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $apply_arg_893
     (global.get $camlStdlib__const_block_889)
    )
    (local.set $apply_funct_894
     (global.get $camlStdlib__open_in_gen_869_closure)
    )
    (return_call $open_in_gen_869
     (local.get $apply_arg_893)
     (local.get $apply_arg_892)
     (local.get $P_name_886)
     (ref.cast (ref $Env)
      (local.get $apply_funct_894)
     )
    )
   )
  )
 )
 (func $open_in_bin_897 (type $Func_1) (param $P_name_900 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $apply_funct_908 (ref eq))
  (local $apply_arg_907 (ref eq))
  (local $apply_arg_906 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_arg_906
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $apply_arg_907
     (global.get $camlStdlib__const_block_903)
    )
    (local.set $apply_funct_908
     (global.get $camlStdlib__open_in_gen_869_closure)
    )
    (return_call $open_in_gen_869
     (local.get $apply_arg_907)
     (local.get $apply_arg_906)
     (local.get $P_name_900)
     (ref.cast (ref $Env)
      (local.get $apply_funct_908)
     )
    )
   )
  )
 )
 (func $input_911 (type $Func_4) (param $P_ic_917 (ref eq)) (param $P_s_916 (ref eq)) (param $P_ofs_915 (ref eq)) (param $P_len_914 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $cond_934 (ref eq))
  (local $Psubint_arg_926 (ref eq))
  (local $Psubint_927 (ref eq))
  (local $Pmakeblock_2273 (ref eq))
  (local $Pintcomp_arg_923 (ref eq))
  (local $Pintcomp_arg_920 (ref eq))
  (local $Pintcomp_924 (ref eq))
  (local $Pintcomp_921 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pintcomp_arg_920
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_921
     (ref.i31
      (i32.lt_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_ofs_915)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_arg_920)
        )
       )
      )
     )
    )
    (local.set $cond_934
     (if (result (ref i31))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $Pintcomp_921)
       )
      )
      (then
       (ref.i31
        (i32.const 1)
       )
      )
      (else
       (local.set $Pintcomp_arg_923
        (ref.i31
         (i32.const 0)
        )
       )
       (local.set $Pintcomp_924
        (ref.i31
         (i32.lt_s
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $P_len_914)
           )
          )
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $Pintcomp_arg_923)
           )
          )
         )
        )
       )
       (if (result (ref i31))
        (i31.get_s
         (ref.cast (ref i31)
          (local.get $Pintcomp_924)
         )
        )
        (then
         (ref.i31
          (i32.const 1)
         )
        )
        (else
         (local.set $Psubint_arg_926
          (ref.i31
           (array.len
            (ref.cast (ref $String)
             (local.get $P_s_916)
            )
           )
          )
         )
         (local.set $Psubint_927
          (ref.i31
           (i32.sub
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $Psubint_arg_926)
             )
            )
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $P_len_914)
             )
            )
           )
          )
         )
         (ref.i31
          (i32.gt_s
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $P_ofs_915)
            )
           )
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $Psubint_927)
            )
           )
          )
         )
        )
       )
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_934)
      )
     )
     (then
      (local.set $Pmakeblock_2273
       (global.get $camlStdlib__Pmakeblock_2450)
      )
      (return
       (tuple.make 2
        (i32.const 1)
        (local.get $Pmakeblock_2273)
       )
      )
     )
     (else
      (call $28
       (local.get $P_ic_917)
       (local.get $P_s_916)
       (local.get $P_ofs_915)
       (local.get $P_len_914)
      )
     )
    )
   )
  )
 )
 (func $unsafe_really_input_942 (type $Func_4) (param $P_ic_948 (ref eq)) (param $P_s_947 (ref eq)) (param $P_ofs_946 (ref eq)) (param $P_len_945 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $raise_arg_965 (ref eq))
  (local $r_954 (ref eq))
  (local $apply_funct_964 (ref eq))
  (local $apply_arg_963 (ref eq))
  (local $apply_arg_962 (ref eq))
  (local $Pintcomp_arg_957 (ref eq))
  (local $Pintcomp_arg_951 (ref eq))
  (local $Pintcomp_958 (ref eq))
  (local $Pintcomp_952 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref i31))
    (local.set $Pintcomp_arg_951
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_952
     (ref.i31
      (i32.le_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_len_945)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_arg_951)
        )
       )
      )
     )
    )
    (if (result (ref i31))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $Pintcomp_952)
      )
     )
     (then
      (ref.i31
       (i32.const 0)
      )
     )
     (else
      (local.set $r_954
       (call $28
        (local.get $P_ic_948)
        (local.get $P_s_947)
        (local.get $P_ofs_946)
        (local.get $P_len_945)
       )
      )
      (local.set $Pintcomp_arg_957
       (ref.i31
        (i32.const 0)
       )
      )
      (local.set $Pintcomp_958
       (ref.i31
        (ref.eq
         (local.get $r_954)
         (local.get $Pintcomp_arg_957)
        )
       )
      )
      (if
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_958)
        )
       )
       (then
        (local.set $raise_arg_965
         (global.get $global$7)
        )
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $raise_arg_965)
         )
        )
       )
       (else
        (local.set $apply_arg_962
         (ref.i31
          (i32.sub
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $P_len_945)
            )
           )
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $r_954)
            )
           )
          )
         )
        )
        (local.set $apply_arg_963
         (ref.i31
          (i32.add
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $P_ofs_946)
            )
           )
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $r_954)
            )
           )
          )
         )
        )
        (local.set $apply_funct_964
         (global.get $camlStdlib__unsafe_really_input_942_closure)
        )
        (return_call $unsafe_really_input_942
         (local.get $P_ic_948)
         (local.get $P_s_947)
         (local.get $apply_arg_963)
         (local.get $apply_arg_962)
         (ref.cast (ref $Env)
          (local.get $apply_funct_964)
         )
        )
       )
      )
     )
    )
   )
  )
 )
 (func $really_input_969 (type $Func_4) (param $P_ic_976 (ref eq)) (param $P_s_975 (ref eq)) (param $P_ofs_974 (ref eq)) (param $P_len_973 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $cond_993 (ref eq))
  (local $apply_funct_994 (ref eq))
  (local $Psubint_arg_985 (ref eq))
  (local $Psubint_986 (ref eq))
  (local $Pmakeblock_2279 (ref eq))
  (local $Pintcomp_arg_982 (ref eq))
  (local $Pintcomp_arg_979 (ref eq))
  (local $Pintcomp_983 (ref eq))
  (local $Pintcomp_980 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Pintcomp_arg_979
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_980
     (ref.i31
      (i32.lt_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_ofs_974)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_arg_979)
        )
       )
      )
     )
    )
    (local.set $cond_993
     (if (result (ref i31))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $Pintcomp_980)
       )
      )
      (then
       (ref.i31
        (i32.const 1)
       )
      )
      (else
       (local.set $Pintcomp_arg_982
        (ref.i31
         (i32.const 0)
        )
       )
       (local.set $Pintcomp_983
        (ref.i31
         (i32.lt_s
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $P_len_973)
           )
          )
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $Pintcomp_arg_982)
           )
          )
         )
        )
       )
       (if (result (ref i31))
        (i31.get_s
         (ref.cast (ref i31)
          (local.get $Pintcomp_983)
         )
        )
        (then
         (ref.i31
          (i32.const 1)
         )
        )
        (else
         (local.set $Psubint_arg_985
          (ref.i31
           (array.len
            (ref.cast (ref $String)
             (local.get $P_s_975)
            )
           )
          )
         )
         (local.set $Psubint_986
          (ref.i31
           (i32.sub
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $Psubint_arg_985)
             )
            )
            (i31.get_s
             (ref.cast (ref i31)
              (local.get $P_len_973)
             )
            )
           )
          )
         )
         (ref.i31
          (i32.gt_s
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $P_ofs_974)
            )
           )
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $Psubint_986)
            )
           )
          )
         )
        )
       )
      )
     )
    )
    (if
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_993)
      )
     )
     (then
      (local.set $Pmakeblock_2279
       (global.get $camlStdlib__Pmakeblock_2451)
      )
      (return
       (tuple.make 2
        (i32.const 1)
        (local.get $Pmakeblock_2279)
       )
      )
     )
     (else
      (local.set $apply_funct_994
       (global.get $camlStdlib__unsafe_really_input_942_closure)
      )
      (return_call $unsafe_really_input_942
       (local.get $P_ic_976)
       (local.get $P_s_975)
       (local.get $P_ofs_974)
       (local.get $P_len_973)
       (ref.cast (ref $Env)
        (local.get $apply_funct_994)
       )
      )
     )
    )
   )
  )
 )
 (func $really_input_string_1001 (type $Func_2) (param $P_ic_1005 (ref eq)) (param $P_len_1004 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#38 (ref eq))
  (local $call_result1#37 i32)
  (local $sequence_1009 (ref eq))
  (local $s_1007 (ref eq))
  (local $ofs_2544 (ref eq))
  (local $cond_2556 (ref eq))
  (local $apply_funct_2559 (ref eq))
  (local $Psubint_arg_2553 (ref eq))
  (local $Psubint_2554 (ref eq))
  (local $Pmakeblock_2557 (ref eq))
  (local $Pintcomp_arg_2549 (ref eq))
  (local $Pintcomp_2550 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_16 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $s_1007
     (call $3_23
      (local.get $P_len_1004)
     )
    )
    (local.set $ofs_2544
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_arg_2549
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_2550
     (ref.i31
      (i32.lt_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_len_1004)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_arg_2549)
        )
       )
      )
     )
    )
    (local.set $cond_2556
     (if (result (ref i31))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $Pintcomp_2550)
       )
      )
      (then
       (ref.i31
        (i32.const 1)
       )
      )
      (else
       (local.set $Psubint_arg_2553
        (ref.i31
         (array.len
          (ref.cast (ref $String)
           (local.get $s_1007)
          )
         )
        )
       )
       (local.set $Psubint_2554
        (ref.i31
         (i32.sub
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $Psubint_arg_2553)
           )
          )
          (i31.get_s
           (ref.cast (ref i31)
            (local.get $P_len_1004)
           )
          )
         )
        )
       )
       (ref.i31
        (i32.gt_s
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $ofs_2544)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Psubint_2554)
          )
         )
        )
       )
      )
     )
    )
    (local.set $sequence_1009
     (if (result (ref eq))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $cond_2556)
       )
      )
      (then
       (local.set $Pmakeblock_2557
        (global.get $camlStdlib__Pmakeblock_2451)
       )
       (return
        (tuple.make 2
         (i32.const 1)
         (local.get $Pmakeblock_2557)
        )
       )
      )
      (else
       (local.set $apply_funct_2559
        (global.get $camlStdlib__unsafe_really_input_942_closure)
       )
       (local.set $call_result1#37
        (block (result i32)
         (local.set $scratch_16
          (tuple.extract 2 0
           (local.tee $scratch
            (call $unsafe_really_input_942
             (local.get $P_ic_1005)
             (local.get $s_1007)
             (local.get $ofs_2544)
             (local.get $P_len_1004)
             (ref.cast (ref $Env)
              (local.get $apply_funct_2559)
             )
            )
           )
          )
         )
         (local.set $call_result2#38
          (tuple.extract 2 1
           (local.get $scratch)
          )
         )
         (local.get $scratch_16)
        )
       )
       (if (result (ref eq))
        (local.get $call_result1#37)
        (then
         (return
          (tuple.make 2
           (i32.const 1)
           (local.get $call_result2#38)
          )
         )
        )
        (else
         (local.get $call_result2#38)
        )
       )
      )
     )
    )
    (local.get $s_1007)
   )
  )
 )
 (func $build_result_1021 (type $Func_3) (param $P_buf_1025 (ref eq)) (param $P_pos_1024 (ref eq)) (param $P_param_1023 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $len_1031 (ref eq))
  (local $hd_1029 (ref eq))
  (local $cond_1028 (ref eq))
  (local $apply_funct_1043 (ref eq))
  (local $apply_arg_1042 (ref eq))
  (local $apply_arg_1041 (ref eq))
  (local $Pccall_arg_1037 (ref eq))
  (local $Pccall_arg_1036 (ref eq))
  (local $Pccall_1038 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $cond_1028
     (ref.i31
      (ref.test (ref i31)
       (local.get $P_param_1023)
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_1028)
      )
     )
     (then
      (local.get $P_buf_1025)
     )
     (else
      (local.set $hd_1029
       (array.get $Array
        (ref.cast (ref $Array)
         (local.get $P_param_1023)
        )
        (i32.const 1)
       )
      )
      (local.set $len_1031
       (ref.i31
        (array.len
         (ref.cast (ref $String)
          (local.get $hd_1029)
         )
        )
       )
      )
      (local.set $Pccall_arg_1036
       (ref.i31
        (i32.sub
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $P_pos_1024)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $len_1031)
          )
         )
        )
       )
      )
      (local.set $Pccall_arg_1037
       (ref.i31
        (i32.const 0)
       )
      )
      (local.set $Pccall_1038
       (call $6_23
        (local.get $hd_1029)
        (local.get $Pccall_arg_1037)
        (local.get $P_buf_1025)
        (local.get $Pccall_arg_1036)
        (local.get $len_1031)
       )
      )
      (local.set $apply_arg_1041
       (array.get $Array
        (ref.cast (ref $Array)
         (local.get $P_param_1023)
        )
        (i32.const 2)
       )
      )
      (local.set $apply_arg_1042
       (ref.i31
        (i32.sub
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $P_pos_1024)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $len_1031)
          )
         )
        )
       )
      )
      (local.set $apply_funct_1043
       (global.get $camlStdlib__build_result_1021_closure)
      )
      (return_call $build_result_1021
       (local.get $P_buf_1025)
       (local.get $apply_arg_1042)
       (local.get $apply_arg_1041)
       (ref.cast (ref $Env)
        (local.get $apply_funct_1043)
       )
      )
     )
    )
   )
  )
 )
 (func $input_line_1015 (type $Func_1) (param $P_chan_1018 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $set_of_closures_1046 (ref eq))
  (local $scan_1044 (ref eq))
  (local $apply_arg_1123 (ref eq))
  (local $apply_arg_1122 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $set_of_closures_1046
     (struct.new $Closure_2_1
      (i32.const 2)
      (ref.func $Caml_curry_2_170)
      (ref.func $scan_1045)
      (local.get $P_chan_1018)
     )
    )
    (local.set $scan_1044
     (local.get $set_of_closures_1046)
    )
    (local.set $apply_arg_1122
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $apply_arg_1123
     (ref.i31
      (i32.const 0)
     )
    )
    (return_call $scan_1045
     (local.get $apply_arg_1123)
     (local.get $apply_arg_1122)
     (ref.cast (ref $Env)
      (local.get $scan_1044)
     )
    )
   )
  )
 )
 (func $scan_1045 (type $Func_2) (param $P_accu_1051 (ref eq)) (param $P_len_1050 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $raise_arg_1118 (ref eq))
  (local $n_1053 (ref eq))
  (local $len_2586 (ref eq))
  (local $ignore_1097 (ref eq))
  (local $cond_1114 (ref eq))
  (local $cond_1101 (ref eq))
  (local $apply_funct_2592 (ref eq))
  (local $apply_funct_1117 (ref eq))
  (local $apply_arg_2591 (ref eq))
  (local $apply_arg_1116 (ref eq))
  (local $apply_arg_1111 (ref eq))
  (local $apply_arg_1078 (ref eq))
  (local $apply_arg_1077 (ref eq))
  (local $Psubint_arg_1106 (ref eq))
  (local $Psubint_arg_1105 (ref eq))
  (local $Psubint_arg_1090 (ref eq))
  (local $Psubint_arg_1082 (ref eq))
  (local $Psubint_1107 (ref eq))
  (local $Psubint_1091 (ref eq))
  (local $Psubint_1083 (ref eq))
  (local $Pintcomp_arg_1060 (ref eq))
  (local $Pintcomp_arg_1056 (ref eq))
  (local $Pintcomp_1061 (ref eq))
  (local $Pintcomp_1057 (ref eq))
  (local $Pccall_arg_2588 (ref eq))
  (local $Pccall_arg_2587 (ref eq))
  (local $Pccall_arg_1093 (ref eq))
  (local $Pccall_arg_1072 (ref eq))
  (local $Pccall_arg_1071 (ref eq))
  (local $Pccall_arg_1065 (ref eq))
  (local $Pccall_2589 (ref eq))
  (local $Pccall_1094 (ref eq))
  (local $Pccall_1085 (ref eq))
  (local $Pccall_1073 (ref eq))
  (local $Pccall_1066 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $n_1053
     (call $27
      (struct.get $Closure_2_1 3
       (ref.cast (ref $Closure_2_1)
        (local.get $Env)
       )
      )
     )
    )
    (local.set $Pintcomp_arg_1056
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_1057
     (ref.i31
      (ref.eq
       (local.get $n_1053)
       (local.get $Pintcomp_arg_1056)
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $Pintcomp_1057)
      )
     )
     (then
      (local.set $cond_1114
       (ref.i31
        (ref.test (ref i31)
         (local.get $P_accu_1051)
        )
       )
      )
      (if
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $cond_1114)
        )
       )
       (then
        (local.set $raise_arg_1118
         (global.get $global$7)
        )
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $raise_arg_1118)
         )
        )
       )
       (else
        (local.set $apply_arg_1116
         (call $3_23
          (local.get $P_len_1050)
         )
        )
        (local.set $apply_funct_1117
         (global.get $camlStdlib__build_result_1021_closure)
        )
        (return_call $build_result_1021
         (local.get $apply_arg_1116)
         (local.get $P_len_1050)
         (local.get $P_accu_1051)
         (ref.cast (ref $Env)
          (local.get $apply_funct_1117)
         )
        )
       )
      )
     )
     (else
      (local.set $Pintcomp_arg_1060
       (ref.i31
        (i32.const 0)
       )
      )
      (local.set $Pintcomp_1061
       (ref.i31
        (i32.gt_s
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $n_1053)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Pintcomp_arg_1060)
          )
         )
        )
       )
      )
      (if (result (ref eq))
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_1061)
        )
       )
       (then
        (local.set $Psubint_arg_1082
         (ref.i31
          (i32.const 1)
         )
        )
        (local.set $Psubint_1083
         (ref.i31
          (i32.sub
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $n_1053)
            )
           )
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $Psubint_arg_1082)
            )
           )
          )
         )
        )
        (local.set $Pccall_1085
         (call $3_23
          (local.get $Psubint_1083)
         )
        )
        (local.set $Psubint_arg_1090
         (ref.i31
          (i32.const 1)
         )
        )
        (local.set $Psubint_1091
         (ref.i31
          (i32.sub
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $n_1053)
            )
           )
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $Psubint_arg_1090)
            )
           )
          )
         )
        )
        (local.set $Pccall_arg_1093
         (ref.i31
          (i32.const 0)
         )
        )
        (local.set $Pccall_1094
         (call $28
          (struct.get $Closure_2_1 3
           (ref.cast (ref $Closure_2_1)
            (local.get $Env)
           )
          )
          (local.get $Pccall_1085)
          (local.get $Pccall_arg_1093)
          (local.get $Psubint_1091)
         )
        )
        (local.set $ignore_1097
         (call $29
          (struct.get $Closure_2_1 3
           (ref.cast (ref $Closure_2_1)
            (local.get $Env)
           )
          )
         )
        )
        (local.set $cond_1101
         (ref.i31
          (ref.test (ref i31)
           (local.get $P_accu_1051)
          )
         )
        )
        (if (result (ref eq))
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $cond_1101)
          )
         )
         (then
          (local.get $Pccall_1085)
         )
         (else
          (local.set $Psubint_arg_1105
           (ref.i31
            (i32.const 1)
           )
          )
          (local.set $Psubint_arg_1106
           (ref.i31
            (i32.add
             (i31.get_s
              (ref.cast (ref i31)
               (local.get $P_len_1050)
              )
             )
             (i31.get_s
              (ref.cast (ref i31)
               (local.get $n_1053)
              )
             )
            )
           )
          )
          (local.set $Psubint_1107
           (ref.i31
            (i32.sub
             (i31.get_s
              (ref.cast (ref i31)
               (local.get $Psubint_arg_1106)
              )
             )
             (i31.get_s
              (ref.cast (ref i31)
               (local.get $Psubint_arg_1105)
              )
             )
            )
           )
          )
          (local.set $apply_arg_1111
           (call $3_23
            (local.get $Psubint_1107)
           )
          )
          (local.set $len_2586
           (ref.i31
            (array.len
             (ref.cast (ref $String)
              (local.get $Pccall_1085)
             )
            )
           )
          )
          (local.set $Pccall_arg_2587
           (ref.i31
            (i32.sub
             (i31.get_s
              (ref.cast (ref i31)
               (local.get $Psubint_1107)
              )
             )
             (i31.get_s
              (ref.cast (ref i31)
               (local.get $len_2586)
              )
             )
            )
           )
          )
          (local.set $Pccall_arg_2588
           (ref.i31
            (i32.const 0)
           )
          )
          (local.set $Pccall_2589
           (call $6_23
            (local.get $Pccall_1085)
            (local.get $Pccall_arg_2588)
            (local.get $apply_arg_1111)
            (local.get $Pccall_arg_2587)
            (local.get $len_2586)
           )
          )
          (local.set $apply_arg_2591
           (ref.i31
            (i32.sub
             (i31.get_s
              (ref.cast (ref i31)
               (local.get $Psubint_1107)
              )
             )
             (i31.get_s
              (ref.cast (ref i31)
               (local.get $len_2586)
              )
             )
            )
           )
          )
          (local.set $apply_funct_2592
           (global.get $camlStdlib__build_result_1021_closure)
          )
          (return_call $build_result_1021
           (local.get $apply_arg_1111)
           (local.get $apply_arg_2591)
           (local.get $P_accu_1051)
           (ref.cast (ref $Env)
            (local.get $apply_funct_2592)
           )
          )
         )
        )
       )
       (else
        (local.set $Pccall_arg_1065
         (ref.i31
          (i32.xor
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $n_1053)
            )
           )
           (i32.const 0)
          )
         )
        )
        (local.set $Pccall_1066
         (call $3_23
          (local.get $Pccall_arg_1065)
         )
        )
        (local.set $Pccall_arg_1071
         (ref.i31
          (i32.xor
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $n_1053)
            )
           )
           (i32.const 0)
          )
         )
        )
        (local.set $Pccall_arg_1072
         (ref.i31
          (i32.const 0)
         )
        )
        (local.set $Pccall_1073
         (call $28
          (struct.get $Closure_2_1 3
           (ref.cast (ref $Closure_2_1)
            (local.get $Env)
           )
          )
          (local.get $Pccall_1066)
          (local.get $Pccall_arg_1072)
          (local.get $Pccall_arg_1071)
         )
        )
        (local.set $apply_arg_1077
         (ref.i31
          (i32.sub
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $P_len_1050)
            )
           )
           (i31.get_s
            (ref.cast (ref i31)
             (local.get $n_1053)
            )
           )
          )
         )
        )
        (local.set $apply_arg_1078
         (array.new_fixed $Array 3
          (ref.i31
           (i32.const 0)
          )
          (local.get $Pccall_1066)
          (local.get $P_accu_1051)
         )
        )
        (return_call $scan_1045
         (local.get $apply_arg_1078)
         (local.get $apply_arg_1077)
         (ref.cast (ref $Env)
          (local.get $Env)
         )
        )
       )
      )
     )
    )
   )
  )
 )
 (func $close_in_noerr_1127 (type $Func_1) (param $P_ic_1129 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $exn_1131 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (block $!exception_handler_1 (result (ref eq))
     (local.tee $exn_1131
      (block $exception_handler_1
       (br $!exception_handler_1
        (call $38
         (local.get $P_ic_1129)
        )
       )
      )
     )
     (ref.i31
      (i32.const 0)
     )
    )
   )
  )
 )
 (func $string_of_format_1354 (type $Func_1) (param $P_param_1356 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (array.get $Array
     (ref.cast (ref $Array)
      (local.get $P_param_1356)
     )
     (i32.const 2)
    )
   )
  )
 )
 (func $^^_1361 (type $Func_2) (param $P_param_1365 (ref eq)) (param $P_param_1364 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#36 (ref eq))
  (local $call_result2#34 (ref eq))
  (local $call_result2#32 (ref eq))
  (local $call_result1#35 i32)
  (local $call_result1#33 i32)
  (local $call_result1#31 i32)
  (local $apply_funct_1384 (ref eq))
  (local $apply_funct_1381 (ref eq))
  (local $apply_arg_1383 (ref eq))
  (local $apply_arg_1382 (ref eq))
  (local $apply_arg_1380 (ref eq))
  (local $apply_arg_1379 (ref eq))
  (local $apply_arg_1370 (ref eq))
  (local $apply_arg_1369 (ref eq))
  (local $Pmakeblock_arg_1386 (ref eq))
  (local $Pmakeblock_arg_1385 (ref eq))
  (local $Pfield_1373 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_21 i32)
  (local $scratch_22 (tuple i32 (ref eq)))
  (local $scratch_23 i32)
  (local $scratch_24 (tuple i32 (ref eq)))
  (local $scratch_25 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Array)))
    (local.set $apply_arg_1379
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_param_1364)
      )
      (i32.const 2)
     )
    )
    (local.set $apply_arg_1380
     (global.get $camlStdlib__const_immstring_1376)
    )
    (local.set $apply_funct_1381
     (global.get $camlStdlib__^_456_closure)
    )
    (local.set $apply_arg_1382
     (block (result (ref eq))
      (local.set $call_result1#31
       (block (result i32)
        (local.set $scratch_21
         (tuple.extract 2 0
          (local.tee $scratch
           (call $^_456
            (local.get $apply_arg_1380)
            (local.get $apply_arg_1379)
            (ref.cast (ref $Env)
             (local.get $apply_funct_1381)
            )
           )
          )
         )
        )
        (local.set $call_result2#32
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_21)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#31)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#32)
         )
        )
       )
       (else
        (local.get $call_result2#32)
       )
      )
     )
    )
    (local.set $apply_arg_1383
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_param_1365)
      )
      (i32.const 2)
     )
    )
    (local.set $apply_funct_1384
     (global.get $camlStdlib__^_456_closure)
    )
    (local.set $Pmakeblock_arg_1385
     (block (result (ref eq))
      (local.set $call_result1#33
       (block (result i32)
        (local.set $scratch_23
         (tuple.extract 2 0
          (local.tee $scratch_22
           (call $^_456
            (local.get $apply_arg_1383)
            (local.get $apply_arg_1382)
            (ref.cast (ref $Env)
             (local.get $apply_funct_1384)
            )
           )
          )
         )
        )
        (local.set $call_result2#34
         (tuple.extract 2 1
          (local.get $scratch_22)
         )
        )
        (local.get $scratch_23)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#33)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#34)
         )
        )
       )
       (else
        (local.get $call_result2#34)
       )
      )
     )
    )
    (local.set $apply_arg_1369
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_param_1364)
      )
      (i32.const 1)
     )
    )
    (local.set $apply_arg_1370
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_param_1365)
      )
      (i32.const 1)
     )
    )
    (local.set $Pfield_1373
     (global.get $camlCamlinternalFormatBasics__concat_fmt_185_closure)
    )
    (local.set $Pmakeblock_arg_1386
     (block (result (ref eq))
      (local.set $call_result1#35
       (block (result i32)
        (local.set $scratch_25
         (tuple.extract 2 0
          (local.tee $scratch_24
           (call $concat_fmt_185
            (local.get $apply_arg_1370)
            (local.get $apply_arg_1369)
            (ref.cast (ref $Env)
             (local.get $Pfield_1373)
            )
           )
          )
         )
        )
        (local.set $call_result2#36
         (tuple.extract 2 1
          (local.get $scratch_24)
         )
        )
        (local.get $scratch_25)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#35)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#36)
         )
        )
       )
       (else
        (local.get $call_result2#36)
       )
      )
     )
    )
    (array.new_fixed $Array 3
     (ref.i31
      (i32.const 0)
     )
     (local.get $Pmakeblock_arg_1386)
     (local.get $Pmakeblock_arg_1385)
    )
   )
  )
 )
 (func $anon_fn_1483 (type $Func_1) (param $P_prim_1485 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $45
     (local.get $P_prim_1485)
    )
   )
  )
 )
 (func $anon_fn_1632 (type $Func_1) (param $P_prim_1634 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $37
     (local.get $P_prim_1634)
    )
   )
  )
 )
 (func $anon_fn_1626 (type $Func_1) (param $P_prim_1628 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $35
     (local.get $P_prim_1628)
    )
   )
  )
 )
 (func $anon_fn_1619 (type $Func_2) (param $P_prim_1622 (ref eq)) (param $P_prim_1621 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $33
     (local.get $P_prim_1622)
     (local.get $P_prim_1621)
    )
   )
  )
 )
 (func $anon_fn_1613 (type $Func_1) (param $P_prim_1615 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $37
     (local.get $P_prim_1615)
    )
   )
  )
 )
 (func $anon_fn_1607 (type $Func_1) (param $P_prim_1609 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $40
     (local.get $P_prim_1609)
    )
   )
  )
 )
 (func $anon_fn_1600 (type $Func_2) (param $P_prim_1603 (ref eq)) (param $P_prim_1602 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $26
     (local.get $P_prim_1603)
     (local.get $P_prim_1602)
    )
   )
  )
 )
 (func $anon_fn_1593 (type $Func_2) (param $P_prim_1596 (ref eq)) (param $P_prim_1595 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $41
     (local.get $P_prim_1596)
     (local.get $P_prim_1595)
    )
   )
  )
 )
 (func $anon_fn_1587 (type $Func_1) (param $P_prim_1589 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $38
     (local.get $P_prim_1589)
    )
   )
  )
 )
 (func $anon_fn_1581 (type $Func_1) (param $P_prim_1583 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $36
     (local.get $P_prim_1583)
    )
   )
  )
 )
 (func $anon_fn_1575 (type $Func_1) (param $P_prim_1577 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $34
     (local.get $P_prim_1577)
    )
   )
  )
 )
 (func $anon_fn_1568 (type $Func_2) (param $P_prim_1571 (ref eq)) (param $P_prim_1570 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $32
     (local.get $P_prim_1571)
     (local.get $P_prim_1570)
    )
   )
  )
 )
 (func $anon_fn_1562 (type $Func_1) (param $P_prim_1564 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $31
     (local.get $P_prim_1564)
    )
   )
  )
 )
 (func $anon_fn_1556 (type $Func_1) (param $P_prim_1558 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $30
     (local.get $P_prim_1558)
    )
   )
  )
 )
 (func $anon_fn_1550 (type $Func_1) (param $P_prim_1552 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $29
     (local.get $P_prim_1552)
    )
   )
  )
 )
 (func $anon_fn_1544 (type $Func_1) (param $P_prim_1546 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $29
     (local.get $P_prim_1546)
    )
   )
  )
 )
 (func $anon_fn_1537 (type $Func_2) (param $P_prim_1540 (ref eq)) (param $P_prim_1539 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $41
     (local.get $P_prim_1540)
     (local.get $P_prim_1539)
    )
   )
  )
 )
 (func $anon_fn_1531 (type $Func_1) (param $P_prim_1533 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $36
     (local.get $P_prim_1533)
    )
   )
  )
 )
 (func $anon_fn_1525 (type $Func_1) (param $P_prim_1527 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $39
     (local.get $P_prim_1527)
    )
   )
  )
 )
 (func $anon_fn_1518 (type $Func_2) (param $P_prim_1521 (ref eq)) (param $P_prim_1520 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $25
     (local.get $P_prim_1521)
     (local.get $P_prim_1520)
    )
   )
  )
 )
 (func $anon_fn_1511 (type $Func_2) (param $P_prim_1514 (ref eq)) (param $P_prim_1513 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $21
     (local.get $P_prim_1514)
     (local.get $P_prim_1513)
    )
   )
  )
 )
 (func $anon_fn_1504 (type $Func_2) (param $P_prim_1507 (ref eq)) (param $P_prim_1506 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $22
     (local.get $P_prim_1507)
     (local.get $P_prim_1506)
    )
   )
  )
 )
 (func $anon_fn_1497 (type $Func_2) (param $P_prim_1500 (ref eq)) (param $P_prim_1499 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $22
     (local.get $P_prim_1500)
     (local.get $P_prim_1499)
    )
   )
  )
 )
 (func $anon_fn_1491 (type $Func_1) (param $P_prim_1493 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (call $18
     (local.get $P_prim_1493)
    )
   )
  )
 )
 (func $do_at_exit_1448 (type $Func_1) (param $P_param_1451 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Indirec_call_closure_1 (ref $Env))
  (local $simplify_fv_2167 (ref eq))
  (local $r_2166 (ref eq))
  (local $apply_arg_1454 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_arg_1454
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $r_2166
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__exit_function_1810)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2167
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $r_2166)
      )
      (i32.const 1)
     )
    )
    (local.set $Indirec_call_closure_1
     (ref.cast (ref $Env)
      (local.get $simplify_fv_2167)
     )
    )
    (return_call_ref $Func_1
     (local.get $apply_arg_1454)
     (local.get $Indirec_call_closure_1)
     (struct.get $Env 1
      (local.get $Indirec_call_closure_1)
     )
    )
   )
  )
 )
 (func $print_char_1136 (type $Func_1) (param $P_c_1139 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stdout_2085 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $stdout_2085
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (call $22
     (local.get $stdout_2085)
     (local.get $P_c_1139)
    )
   )
  )
 )
 (func $print_string_1144 (type $Func_1) (param $P_s_1148 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stdout_2087 (ref eq))
  (local $apply_funct_1150 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_funct_1150
     (global.get $camlStdlib__output_string_763_closure)
    )
    (local.set $stdout_2087
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (return_call $output_string_763
     (local.get $stdout_2087)
     (local.get $P_s_1148)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1150)
     )
    )
   )
  )
 )
 (func $print_bytes_1153 (type $Func_1) (param $P_s_1157 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stdout_2088 (ref eq))
  (local $apply_funct_1159 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_funct_1159
     (global.get $camlStdlib__output_bytes_751_closure)
    )
    (local.set $stdout_2088
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (return_call $output_bytes_751
     (local.get $stdout_2088)
     (local.get $P_s_1157)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1159)
     )
    )
   )
  )
 )
 (func $print_int_1162 (type $Func_1) (param $P_i_1167 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stdout_2089 (ref eq))
  (local $apply_funct_1171 (ref eq))
  (local $Pccall_arg_2258 (ref eq))
  (local $Pccall_2259 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Pccall_arg_2258
     (global.get $camlStdlib__const_immstring_542)
    )
    (local.set $Pccall_2259
     (call $11_23
      (local.get $Pccall_arg_2258)
      (local.get $P_i_1167)
     )
    )
    (local.set $apply_funct_1171
     (global.get $camlStdlib__output_string_763_closure)
    )
    (local.set $stdout_2089
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (return_call $output_string_763
     (local.get $stdout_2089)
     (local.get $Pccall_2259)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1171)
     )
    )
   )
  )
 )
 (func $print_float_1174 (type $Func_1) (param $P_f_1179 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#30 (ref eq))
  (local $call_result1#29 i32)
  (local $stdout_2090 (ref eq))
  (local $apply_funct_2640 (ref eq))
  (local $apply_funct_1183 (ref eq))
  (local $apply_arg_1182 (ref eq))
  (local $Pccall_arg_2638 (ref eq))
  (local $Pccall_2639 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_11 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Pccall_arg_2638
     (global.get $camlStdlib__const_immstring_616)
    )
    (local.set $Pccall_2639
     (call $12_23
      (local.get $Pccall_arg_2638)
      (local.get $P_f_1179)
     )
    )
    (local.set $apply_funct_2640
     (global.get $camlStdlib__valid_float_lexem_566_closure)
    )
    (local.set $apply_arg_1182
     (block (result (ref eq))
      (local.set $call_result1#29
       (block (result i32)
        (local.set $scratch_11
         (tuple.extract 2 0
          (local.tee $scratch
           (call $valid_float_lexem_566
            (local.get $Pccall_2639)
            (ref.cast (ref $Env)
             (local.get $apply_funct_2640)
            )
           )
          )
         )
        )
        (local.set $call_result2#30
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_11)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#29)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#30)
         )
        )
       )
       (else
        (local.get $call_result2#30)
       )
      )
     )
    )
    (local.set $apply_funct_1183
     (global.get $camlStdlib__output_string_763_closure)
    )
    (local.set $stdout_2090
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (return_call $output_string_763
     (local.get $stdout_2090)
     (local.get $apply_arg_1182)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1183)
     )
    )
   )
  )
 )
 (func $print_endline_1186 (type $Func_1) (param $P_s_1190 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#28 (ref eq))
  (local $call_result1#27 i32)
  (local $stdout_2094 (ref eq))
  (local $stdout_2092 (ref eq))
  (local $stdout_2091 (ref eq))
  (local $simplify_fv_2093 (ref eq))
  (local $sequence_1192 (ref eq))
  (local $apply_funct_1193 (ref eq))
  (local $Pccall_arg_1196 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_12 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $apply_funct_1193
     (global.get $camlStdlib__output_string_763_closure)
    )
    (local.set $stdout_2091
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (local.set $sequence_1192
     (block (result (ref eq))
      (local.set $call_result1#27
       (block (result i32)
        (local.set $scratch_12
         (tuple.extract 2 0
          (local.tee $scratch
           (call $output_string_763
            (local.get $stdout_2091)
            (local.get $P_s_1190)
            (ref.cast (ref $Env)
             (local.get $apply_funct_1193)
            )
           )
          )
         )
        )
        (local.set $call_result2#28
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_12)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#27)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#28)
         )
        )
       )
       (else
        (local.get $call_result2#28)
       )
      )
     )
    )
    (local.set $Pccall_arg_1196
     (ref.i31
      (i32.const 10)
     )
    )
    (local.set $stdout_2092
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2093
     (call $22
      (local.get $stdout_2092)
      (local.get $Pccall_arg_1196)
     )
    )
    (local.set $stdout_2094
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (call $18
     (local.get $stdout_2094)
    )
   )
  )
 )
 (func $print_newline_1201 (type $Func_1) (param $P_param_1204 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stdout_2098 (ref eq))
  (local $stdout_2096 (ref eq))
  (local $simplify_fv_2097 (ref eq))
  (local $Pccall_arg_1208 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pccall_arg_1208
     (ref.i31
      (i32.const 10)
     )
    )
    (local.set $stdout_2096
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2097
     (call $22
      (local.get $stdout_2096)
      (local.get $Pccall_arg_1208)
     )
    )
    (local.set $stdout_2098
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (call $18
     (local.get $stdout_2098)
    )
   )
  )
 )
 (func $prerr_char_1213 (type $Func_1) (param $P_c_1216 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stderr_2100 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $stderr_2100
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (call $22
     (local.get $stderr_2100)
     (local.get $P_c_1216)
    )
   )
  )
 )
 (func $prerr_string_1221 (type $Func_1) (param $P_s_1225 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stderr_2102 (ref eq))
  (local $apply_funct_1227 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_funct_1227
     (global.get $camlStdlib__output_string_763_closure)
    )
    (local.set $stderr_2102
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (return_call $output_string_763
     (local.get $stderr_2102)
     (local.get $P_s_1225)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1227)
     )
    )
   )
  )
 )
 (func $prerr_bytes_1230 (type $Func_1) (param $P_s_1234 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stderr_2103 (ref eq))
  (local $apply_funct_1236 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_funct_1236
     (global.get $camlStdlib__output_bytes_751_closure)
    )
    (local.set $stderr_2103
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (return_call $output_bytes_751
     (local.get $stderr_2103)
     (local.get $P_s_1234)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1236)
     )
    )
   )
  )
 )
 (func $prerr_int_1239 (type $Func_1) (param $P_i_1244 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stderr_2104 (ref eq))
  (local $apply_funct_1248 (ref eq))
  (local $Pccall_arg_2264 (ref eq))
  (local $Pccall_2265 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Pccall_arg_2264
     (global.get $camlStdlib__const_immstring_542)
    )
    (local.set $Pccall_2265
     (call $11_23
      (local.get $Pccall_arg_2264)
      (local.get $P_i_1244)
     )
    )
    (local.set $apply_funct_1248
     (global.get $camlStdlib__output_string_763_closure)
    )
    (local.set $stderr_2104
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (return_call $output_string_763
     (local.get $stderr_2104)
     (local.get $Pccall_2265)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1248)
     )
    )
   )
  )
 )
 (func $prerr_float_1251 (type $Func_1) (param $P_f_1256 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#26 (ref eq))
  (local $call_result1#25 i32)
  (local $stderr_2105 (ref eq))
  (local $apply_funct_2644 (ref eq))
  (local $apply_funct_1260 (ref eq))
  (local $apply_arg_1259 (ref eq))
  (local $Pccall_arg_2642 (ref eq))
  (local $Pccall_2643 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_11 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Pccall_arg_2642
     (global.get $camlStdlib__const_immstring_616)
    )
    (local.set $Pccall_2643
     (call $12_23
      (local.get $Pccall_arg_2642)
      (local.get $P_f_1256)
     )
    )
    (local.set $apply_funct_2644
     (global.get $camlStdlib__valid_float_lexem_566_closure)
    )
    (local.set $apply_arg_1259
     (block (result (ref eq))
      (local.set $call_result1#25
       (block (result i32)
        (local.set $scratch_11
         (tuple.extract 2 0
          (local.tee $scratch
           (call $valid_float_lexem_566
            (local.get $Pccall_2643)
            (ref.cast (ref $Env)
             (local.get $apply_funct_2644)
            )
           )
          )
         )
        )
        (local.set $call_result2#26
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_11)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#25)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#26)
         )
        )
       )
       (else
        (local.get $call_result2#26)
       )
      )
     )
    )
    (local.set $apply_funct_1260
     (global.get $camlStdlib__output_string_763_closure)
    )
    (local.set $stderr_2105
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (return_call $output_string_763
     (local.get $stderr_2105)
     (local.get $apply_arg_1259)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1260)
     )
    )
   )
  )
 )
 (func $prerr_endline_1263 (type $Func_1) (param $P_s_1267 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#24 (ref eq))
  (local $call_result1#23 i32)
  (local $stderr_2109 (ref eq))
  (local $stderr_2107 (ref eq))
  (local $stderr_2106 (ref eq))
  (local $simplify_fv_2108 (ref eq))
  (local $sequence_1269 (ref eq))
  (local $apply_funct_1270 (ref eq))
  (local $Pccall_arg_1273 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_12 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $apply_funct_1270
     (global.get $camlStdlib__output_string_763_closure)
    )
    (local.set $stderr_2106
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (local.set $sequence_1269
     (block (result (ref eq))
      (local.set $call_result1#23
       (block (result i32)
        (local.set $scratch_12
         (tuple.extract 2 0
          (local.tee $scratch
           (call $output_string_763
            (local.get $stderr_2106)
            (local.get $P_s_1267)
            (ref.cast (ref $Env)
             (local.get $apply_funct_1270)
            )
           )
          )
         )
        )
        (local.set $call_result2#24
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_12)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#23)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#24)
         )
        )
       )
       (else
        (local.get $call_result2#24)
       )
      )
     )
    )
    (local.set $Pccall_arg_1273
     (ref.i31
      (i32.const 10)
     )
    )
    (local.set $stderr_2107
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2108
     (call $22
      (local.get $stderr_2107)
      (local.get $Pccall_arg_1273)
     )
    )
    (local.set $stderr_2109
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (call $18
     (local.get $stderr_2109)
    )
   )
  )
 )
 (func $prerr_newline_1278 (type $Func_1) (param $P_param_1281 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stderr_2113 (ref eq))
  (local $stderr_2111 (ref eq))
  (local $simplify_fv_2112 (ref eq))
  (local $Pccall_arg_1285 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pccall_arg_1285
     (ref.i31
      (i32.const 10)
     )
    )
    (local.set $stderr_2111
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2112
     (call $22
      (local.get $stderr_2111)
      (local.get $Pccall_arg_1285)
     )
    )
    (local.set $stderr_2113
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1850)
      )
      (i32.const 1)
     )
    )
    (call $18
     (local.get $stderr_2113)
    )
   )
  )
 )
 (func $read_line_1290 (type $Func_1) (param $P_param_1295 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $stdout_2115 (ref eq))
  (local $stdin_2117 (ref eq))
  (local $simplify_fv_2116 (ref eq))
  (local $apply_funct_1299 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $stdout_2115
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2116
     (call $18
      (local.get $stdout_2115)
     )
    )
    (local.set $apply_funct_1299
     (global.get $camlStdlib__input_line_1015_closure)
    )
    (local.set $stdin_2117
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1852)
      )
      (i32.const 1)
     )
    )
    (return_call $input_line_1015
     (local.get $stdin_2117)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1299)
     )
    )
   )
  )
 )
 (func $read_int_1302 (type $Func_1) (param $P_param_1305 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#22 (ref eq))
  (local $call_result1#21 i32)
  (local $stdout_2121 (ref eq))
  (local $stdin_2125 (ref eq))
  (local $simplify_fv_2122 (ref eq))
  (local $apply_funct_2124 (ref eq))
  (local $Pccall_arg_1310 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_10 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $stdout_2121
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2122
     (call $18
      (local.get $stdout_2121)
     )
    )
    (local.set $apply_funct_2124
     (global.get $camlStdlib__input_line_1015_closure)
    )
    (local.set $stdin_2125
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1852)
      )
      (i32.const 1)
     )
    )
    (local.set $Pccall_arg_1310
     (block (result (ref eq))
      (local.set $call_result1#21
       (block (result i32)
        (local.set $scratch_10
         (tuple.extract 2 0
          (local.tee $scratch
           (call $input_line_1015
            (local.get $stdin_2125)
            (ref.cast (ref $Env)
             (local.get $apply_funct_2124)
            )
           )
          )
         )
        )
        (local.set $call_result2#22
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_10)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#21)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#22)
         )
        )
       )
       (else
        (local.get $call_result2#22)
       )
      )
     )
    )
    (call $13
     (local.get $Pccall_arg_1310)
    )
   )
  )
 )
 (func $read_int_opt_1314 (type $Func_1) (param $P_param_1318 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#20 (ref eq))
  (local $call_result1#19 i32)
  (local $stdout_2129 (ref eq))
  (local $stdin_2133 (ref eq))
  (local $simplify_fv_2130 (ref eq))
  (local $apply_funct_2132 (ref eq))
  (local $apply_funct_1324 (ref eq))
  (local $apply_arg_1323 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_11 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $stdout_2129
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2130
     (call $18
      (local.get $stdout_2129)
     )
    )
    (local.set $apply_funct_2132
     (global.get $camlStdlib__input_line_1015_closure)
    )
    (local.set $stdin_2133
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1852)
      )
      (i32.const 1)
     )
    )
    (local.set $apply_arg_1323
     (block (result (ref eq))
      (local.set $call_result1#19
       (block (result i32)
        (local.set $scratch_11
         (tuple.extract 2 0
          (local.tee $scratch
           (call $input_line_1015
            (local.get $stdin_2133)
            (ref.cast (ref $Env)
             (local.get $apply_funct_2132)
            )
           )
          )
         )
        )
        (local.set $call_result2#20
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_11)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#19)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#20)
         )
        )
       )
       (else
        (local.get $call_result2#20)
       )
      )
     )
    )
    (local.set $apply_funct_1324
     (global.get $camlStdlib__int_of_string_opt_548_closure)
    )
    (return_call $int_of_string_opt_548
     (local.get $apply_arg_1323)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1324)
     )
    )
   )
  )
 )
 (func $read_float_1327 (type $Func_1) (param $P_param_1330 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#18 (ref eq))
  (local $call_result1#17 i32)
  (local $stdout_2137 (ref eq))
  (local $stdin_2141 (ref eq))
  (local $simplify_fv_2138 (ref eq))
  (local $apply_funct_2140 (ref eq))
  (local $Pccall_arg_1335 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_10 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $stdout_2137
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2138
     (call $18
      (local.get $stdout_2137)
     )
    )
    (local.set $apply_funct_2140
     (global.get $camlStdlib__input_line_1015_closure)
    )
    (local.set $stdin_2141
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1852)
      )
      (i32.const 1)
     )
    )
    (local.set $Pccall_arg_1335
     (block (result (ref eq))
      (local.set $call_result1#17
       (block (result i32)
        (local.set $scratch_10
         (tuple.extract 2 0
          (local.tee $scratch
           (call $input_line_1015
            (local.get $stdin_2141)
            (ref.cast (ref $Env)
             (local.get $apply_funct_2140)
            )
           )
          )
         )
        )
        (local.set $call_result2#18
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_10)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#17)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#18)
         )
        )
       )
       (else
        (local.get $call_result2#18)
       )
      )
     )
    )
    (call $14
     (local.get $Pccall_arg_1335)
    )
   )
  )
 )
 (func $read_float_opt_1339 (type $Func_1) (param $P_param_1343 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#16 (ref eq))
  (local $call_result1#15 i32)
  (local $stdout_2145 (ref eq))
  (local $stdin_2149 (ref eq))
  (local $simplify_fv_2146 (ref eq))
  (local $apply_funct_2148 (ref eq))
  (local $apply_funct_1349 (ref eq))
  (local $apply_arg_1348 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_11 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $stdout_2145
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2146
     (call $18
      (local.get $stdout_2145)
     )
    )
    (local.set $apply_funct_2148
     (global.get $camlStdlib__input_line_1015_closure)
    )
    (local.set $stdin_2149
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1852)
      )
      (i32.const 1)
     )
    )
    (local.set $apply_arg_1348
     (block (result (ref eq))
      (local.set $call_result1#15
       (block (result i32)
        (local.set $scratch_11
         (tuple.extract 2 0
          (local.tee $scratch
           (call $input_line_1015
            (local.get $stdin_2149)
            (ref.cast (ref $Env)
             (local.get $apply_funct_2148)
            )
           )
          )
         )
        )
        (local.set $call_result2#16
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_11)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#15)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#16)
         )
        )
       )
       (else
        (local.get $call_result2#16)
       )
      )
     )
    )
    (local.set $apply_funct_1349
     (global.get $camlStdlib__float_of_string_opt_624_closure)
    )
    (return_call $float_of_string_opt_624
     (local.get $apply_arg_1348)
     (ref.cast (ref $Env)
      (local.get $apply_funct_1349)
     )
    )
   )
  )
 )
 (func $at_exit_1395 (type $Func_1) (param $P_f_1398 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#14 (ref eq))
  (local $call_result1#13 i32)
  (local $v_2153 (ref eq))
  (local $success_1438 (ref eq))
  (local $simplify_fv_2159 (ref eq))
  (local $r_2158 (ref eq))
  (local $new_exit_1437 (ref eq))
  (local $new_exit_1414 (ref eq))
  (local $exit_function_2162 (ref eq))
  (local $cond_1444 (ref eq))
  (local $Pmakeblock_2154 (ref eq))
  (local $Pfield_1441 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_15 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref i31))
    (local.set $v_2153
     (ref.i31
      (i32.const 1)
     )
    )
    (local.set $Pmakeblock_2154
     (array.new_fixed $Array 2
      (ref.i31
       (i32.const 0)
      )
      (local.get $v_2153)
     )
    )
    (local.set $r_2158
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__exit_function_1810)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2159
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $r_2158)
      )
      (i32.const 1)
     )
    )
    (local.set $new_exit_1414
     (struct.new $Closure_1_3
      (i32.const 1)
      (ref.func $new_exit_1413)
      (local.get $P_f_1398)
      (local.get $Pmakeblock_2154)
      (local.get $simplify_fv_2159)
     )
    )
    (local.set $new_exit_1437
     (local.get $new_exit_1414)
    )
    (local.set $Pfield_1441
     (global.get $camlCamlinternalAtomic__compare_and_set_59_closure)
    )
    (local.set $exit_function_2162
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__exit_function_1810)
      )
      (i32.const 1)
     )
    )
    (local.set $success_1438
     (block (result (ref eq))
      (local.set $call_result1#13
       (block (result i32)
        (local.set $scratch_15
         (tuple.extract 2 0
          (local.tee $scratch
           (call $compare_and_set_59
            (local.get $exit_function_2162)
            (local.get $simplify_fv_2159)
            (local.get $new_exit_1437)
            (ref.cast (ref $Env)
             (local.get $Pfield_1441)
            )
           )
          )
         )
        )
        (local.set $call_result2#14
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_15)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#13)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#14)
         )
        )
       )
       (else
        (local.get $call_result2#14)
       )
      )
     )
    )
    (local.set $cond_1444
     (ref.i31
      (i32.sub
       (i32.const 1)
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $success_1438)
        )
       )
      )
     )
    )
    (if (result (ref i31))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_1444)
      )
     )
     (then
      (return_call $at_exit_1395
       (local.get $P_f_1398)
       (ref.cast (ref $Closure_1_0)
        (global.get $camlStdlib__at_exit_1395_closure)
       )
      )
     )
     (else
      (ref.i31
       (i32.const 0)
      )
     )
    )
   )
  )
 )
 (func $new_exit_1413 (type $Func_1) (param $P_param_1418 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Indirec_call_closure_1 (ref $Env))
  (local $call_result2#12 (ref eq))
  (local $call_result2#10 (ref eq))
  (local $call_result1#11 i32)
  (local $call_result1#9 i32)
  (local $sequence_1420 (ref eq))
  (local $cond_1429 (ref eq))
  (local $apply_arg_1435 (ref eq))
  (local $apply_arg_1432 (ref eq))
  (local $apply_arg_1424 (ref eq))
  (local $apply_arg_1423 (ref eq))
  (local $Pfield_1427 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_15 i32)
  (local $scratch_16 (tuple i32 (ref eq)))
  (local $scratch_17 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_arg_1423
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $apply_arg_1424
     (ref.i31
      (i32.const 1)
     )
    )
    (local.set $Pfield_1427
     (global.get $camlCamlinternalAtomic__compare_and_set_59_closure)
    )
    (local.set $cond_1429
     (block (result (ref eq))
      (local.set $call_result1#9
       (block (result i32)
        (local.set $scratch_15
         (tuple.extract 2 0
          (local.tee $scratch
           (call $compare_and_set_59
            (struct.get $Closure_1_3 3
             (ref.cast (ref $Closure_1_3)
              (local.get $Env)
             )
            )
            (local.get $apply_arg_1424)
            (local.get $apply_arg_1423)
            (ref.cast (ref $Env)
             (local.get $Pfield_1427)
            )
           )
          )
         )
        )
        (local.set $call_result2#10
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_15)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#9)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#10)
         )
        )
       )
       (else
        (local.get $call_result2#10)
       )
      )
     )
    )
    (local.set $sequence_1420
     (if (result (ref eq))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $cond_1429)
       )
      )
      (then
       (local.set $apply_arg_1432
        (ref.i31
         (i32.const 0)
        )
       )
       (local.set $Indirec_call_closure_1
        (ref.cast (ref $Env)
         (struct.get $Closure_1_3 2
          (ref.cast (ref $Closure_1_3)
           (local.get $Env)
          )
         )
        )
       )
       (local.set $call_result1#11
        (block (result i32)
         (local.set $scratch_17
          (tuple.extract 2 0
           (local.tee $scratch_16
            (call_ref $Func_1
             (local.get $apply_arg_1432)
             (local.get $Indirec_call_closure_1)
             (struct.get $Env 1
              (local.get $Indirec_call_closure_1)
             )
            )
           )
          )
         )
         (local.set $call_result2#12
          (tuple.extract 2 1
           (local.get $scratch_16)
          )
         )
         (local.get $scratch_17)
        )
       )
       (if (result (ref eq))
        (local.get $call_result1#11)
        (then
         (return
          (tuple.make 2
           (i32.const 1)
           (local.get $call_result2#12)
          )
         )
        )
        (else
         (local.get $call_result2#12)
        )
       )
      )
      (else
       (ref.i31
        (i32.const 0)
       )
      )
     )
    )
    (local.set $apply_arg_1435
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Indirec_call_closure_1
     (ref.cast (ref $Env)
      (struct.get $Closure_1_3 4
       (ref.cast (ref $Closure_1_3)
        (local.get $Env)
       )
      )
     )
    )
    (return_call_ref $Func_1
     (local.get $apply_arg_1435)
     (local.get $Indirec_call_closure_1)
     (struct.get $Env 1
      (local.get $Indirec_call_closure_1)
     )
    )
   )
  )
 )
 (func $exit_1461 (type $Func_1) (param $P_retcode_1464 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Indirec_call_closure_1 (ref $Env))
  (local $call_result2#8 (ref eq))
  (local $call_result1#7 i32)
  (local $simplify_fv_2176 (ref eq))
  (local $sequence_1466 (ref eq))
  (local $r_2175 (ref eq))
  (local $apply_arg_2173 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_10 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $apply_arg_2173
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $r_2175
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__exit_function_1810)
      )
      (i32.const 1)
     )
    )
    (local.set $simplify_fv_2176
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $r_2175)
      )
      (i32.const 1)
     )
    )
    (local.set $sequence_1466
     (block (result (ref eq))
      (local.set $Indirec_call_closure_1
       (ref.cast (ref $Env)
        (local.get $simplify_fv_2176)
       )
      )
      (local.set $call_result1#7
       (block (result i32)
        (local.set $scratch_10
         (tuple.extract 2 0
          (local.tee $scratch
           (call_ref $Func_1
            (local.get $apply_arg_2173)
            (local.get $Indirec_call_closure_1)
            (struct.get $Env 1
             (local.get $Indirec_call_closure_1)
            )
           )
          )
         )
        )
        (local.set $call_result2#8
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_10)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#7)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#8)
         )
        )
       )
       (else
        (local.get $call_result2#8)
       )
      )
     )
    )
    (call $43
     (local.get $P_retcode_1464)
    )
   )
  )
 )
 (func $new_exit_2705 (type $Func_1) (param $P_param_2706 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Indirec_call_closure_1 (ref $Env))
  (local $call_result2#6 (ref eq))
  (local $call_result1#5 i32)
  (local $sequence_2722 (ref eq))
  (local $prim_2718 (ref eq))
  (local $cond_2710 (ref eq))
  (local $apply_arg_2723 (ref eq))
  (local $apply_arg_2708 (ref eq))
  (local $apply_arg_2707 (ref eq))
  (local $Pfield_2709 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_13 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $apply_arg_2707
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $apply_arg_2708
     (ref.i31
      (i32.const 1)
     )
    )
    (local.set $Pfield_2709
     (global.get $camlCamlinternalAtomic__compare_and_set_59_closure)
    )
    (local.set $cond_2710
     (block (result (ref eq))
      (local.set $call_result1#5
       (block (result i32)
        (local.set $scratch_13
         (tuple.extract 2 0
          (local.tee $scratch
           (call $compare_and_set_59
            (struct.get $Closure_1_2 2
             (ref.cast (ref $Closure_1_2)
              (local.get $Env)
             )
            )
            (local.get $apply_arg_2708)
            (local.get $apply_arg_2707)
            (ref.cast (ref $Env)
             (local.get $Pfield_2709)
            )
           )
          )
         )
        )
        (local.set $call_result2#6
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_13)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#5)
       (then
        (return
         (tuple.make 2
          (i32.const 1)
          (local.get $call_result2#6)
         )
        )
       )
       (else
        (local.get $call_result2#6)
       )
      )
     )
    )
    (local.set $sequence_2722
     (if (result (ref eq))
      (i31.get_s
       (ref.cast (ref i31)
        (local.get $cond_2710)
       )
      )
      (then
       (local.set $prim_2718
        (ref.i31
         (i32.const 0)
        )
       )
       (call $45
        (local.get $prim_2718)
       )
      )
      (else
       (ref.i31
        (i32.const 0)
       )
      )
     )
    )
    (local.set $apply_arg_2723
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Indirec_call_closure_1
     (ref.cast (ref $Env)
      (struct.get $Closure_1_2 3
       (ref.cast (ref $Closure_1_2)
        (local.get $Env)
       )
      )
     )
    )
    (return_call_ref $Func_1
     (local.get $apply_arg_2723)
     (local.get $Indirec_call_closure_1)
     (struct.get $Env 1
      (local.get $Indirec_call_closure_1)
     )
    )
   )
  )
 )
 (func $merged.start.new_319 (type $22)
  (call $R_not_really_start_170)
 )
 (func $Caml_curry_3_2_321 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Gen_closure_3))
  (local $Partial_closure (ref $Partial_closure_3_2))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Partial_closure
     (ref.cast (ref $Partial_closure_3_2)
      (local.get $Env)
     )
    )
    (local.set $Closure
     (struct.get $Partial_closure_3_2 2
      (local.get $Partial_closure)
     )
    )
    (return_call_ref $Func_3
     (struct.get $Partial_closure_3_2 3
      (local.get $Partial_closure)
     )
     (struct.get $Partial_closure_3_2 4
      (local.get $Partial_closure)
     )
     (local.get $P_arg_0)
     (local.get $Closure)
     (struct.get $Gen_closure_3 2
      (local.get $Closure)
     )
    )
   )
  )
 )
 (func $Caml_curry_3_1_321 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Partial_closure_3_1))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_3_2)))
    (local.set $Closure
     (ref.cast (ref $Partial_closure_3_1)
      (local.get $Env)
     )
    )
    (struct.new $Partial_closure_3_2
     (i32.const 1)
     (ref.func $Caml_curry_3_2_321)
     (struct.get $Partial_closure_3_1 2
      (local.get $Closure)
     )
     (struct.get $Partial_closure_3_1 3
      (local.get $Closure)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $Caml_curry_3_321 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_3_1)))
    (struct.new $Partial_closure_3_1
     (i32.const 1)
     (ref.func $Caml_curry_3_1_321)
     (ref.cast (ref $Gen_closure_3)
      (local.get $Env)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $Caml_curry_2_1_321 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $Closure (ref $Gen_closure_2))
  (local $Partial_closure (ref $Partial_closure_2_1))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $Partial_closure
     (ref.cast (ref $Partial_closure_2_1)
      (local.get $Env)
     )
    )
    (local.set $Closure
     (struct.get $Partial_closure_2_1 2
      (local.get $Partial_closure)
     )
    )
    (return_call_ref $Func_2
     (struct.get $Partial_closure_2_1 3
      (local.get $Partial_closure)
     )
     (local.get $P_arg_0)
     (local.get $Closure)
     (struct.get $Gen_closure_2 2
      (local.get $Closure)
     )
    )
   )
  )
 )
 (func $Caml_curry_2_321 (type $Func_1) (param $P_arg_0 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref (exact $Partial_closure_2_1)))
    (struct.new $Partial_closure_2_1
     (i32.const 1)
     (ref.func $Caml_curry_2_1_321)
     (ref.cast (ref $Gen_closure_2)
      (local.get $Env)
     )
     (local.get $P_arg_0)
    )
   )
  )
 )
 (func $R_not_really_start_321 (type $22)
  (local $call_result2#22 (ref eq))
  (local $call_result2#20 (ref eq))
  (local $call_result2#18 (ref eq))
  (local $call_result2#16 (ref eq))
  (local $call_result2#14 (ref eq))
  (local $call_result2#12 (ref eq))
  (local $call_result2#10 (ref eq))
  (local $call_result2#8 (ref eq))
  (local $call_result2#6 (ref eq))
  (local $call_result2#4 (ref eq))
  (local $call_result2#2 (ref eq))
  (local $call_result1#21 i32)
  (local $call_result1#19 i32)
  (local $call_result1#17 i32)
  (local $call_result1#15 i32)
  (local $call_result1#13 i32)
  (local $call_result1#11 i32)
  (local $call_result1#9 i32)
  (local $call_result1#7 i32)
  (local $call_result1#5 i32)
  (local $call_result1#3 i32)
  (local $call_result1#1 i32)
  (local $tak_174 (ref eq))
  (local $stdout_135 (ref eq))
  (local $param_235 (ref eq))
  (local $param_233 (ref eq))
  (local $param_231 (ref eq))
  (local $param_215 (ref eq))
  (local $param_213 (ref eq))
  (local $param_211 (ref eq))
  (local $apply_funct_194 (ref eq))
  (local $apply_funct_134 (ref eq))
  (local $apply_arg_145 (ref eq))
  (local $accu_169 (ref eq))
  (local $Psubint_244 (ref eq))
  (local $Psubint_241 (ref eq))
  (local $Psubint_238 (ref eq))
  (local $Psubint_224 (ref eq))
  (local $Psubint_221 (ref eq))
  (local $Psubint_218 (ref eq))
  (local $Psubint_193 (ref eq))
  (local $Pmakeblock_arg_245 (ref eq))
  (local $Pmakeblock_arg_242 (ref eq))
  (local $Pmakeblock_arg_239 (ref eq))
  (local $Pmakeblock_arg_225 (ref eq))
  (local $Pmakeblock_arg_222 (ref eq))
  (local $Pmakeblock_arg_219 (ref eq))
  (local $Pmakeblock_arg_189 (ref eq))
  (local $Pmakeblock_arg_187 (ref eq))
  (local $Pmakeblock_arg_185 (ref eq))
  (local $Pccall_arg_146 (ref eq))
  (local $Pccall_147 (ref eq))
  (local $Paddint_arg_190 (ref eq))
  (local $Paddint_191 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_55 i32)
  (local $scratch_56 (tuple i32 (ref eq)))
  (local $scratch_57 i32)
  (local $scratch_58 (tuple i32 (ref eq)))
  (local $scratch_59 i32)
  (local $scratch_60 (tuple i32 (ref eq)))
  (local $scratch_61 i32)
  (local $scratch_62 (tuple i32 (ref eq)))
  (local $scratch_63 i32)
  (local $scratch_64 (tuple i32 (ref eq)))
  (local $scratch_65 i32)
  (local $scratch_66 (tuple i32 (ref eq)))
  (local $scratch_67 i32)
  (local $scratch_68 (tuple i32 (ref eq)))
  (local $scratch_69 i32)
  (local $scratch_70 (tuple i32 (ref eq)))
  (local $scratch_71 i32)
  (local $scratch_72 (tuple i32 (ref eq)))
  (local $scratch_73 i32)
  (local $scratch_74 (tuple i32 (ref eq)))
  (local $scratch_75 i32)
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlTaku__apply_arg_92)
   )
   (i32.const 1)
   (block (result (ref eq))
    (local.set $accu_169
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $tak_174
     (global.get $camlTaku__tak_43_closure)
    )
    (local.set $Pmakeblock_arg_185
     (ref.i31
      (i32.const 12)
     )
    )
    (local.set $param_211
     (ref.i31
      (i32.const 18)
     )
    )
    (local.set $param_213
     (ref.i31
      (i32.const 6)
     )
    )
    (local.set $param_215
     (ref.i31
      (i32.const 11)
     )
    )
    (local.set $Psubint_218
     (ref.i31
      (i32.const 17)
     )
    )
    (local.set $Pmakeblock_arg_219
     (block (result (ref eq))
      (local.set $call_result1#1
       (block (result i32)
        (local.set $scratch_55
         (tuple.extract 2 0
          (local.tee $scratch
           (call $tak_43
            (local.get $Psubint_218)
            (local.get $param_215)
            (local.get $param_213)
            (ref.cast (ref $Env)
             (local.get $tak_174)
            )
           )
          )
         )
        )
        (local.set $call_result2#2
         (tuple.extract 2 1
          (local.get $scratch)
         )
        )
        (local.get $scratch_55)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#1)
       (then
        (unreachable)
       )
       (else
        (local.get $call_result2#2)
       )
      )
     )
    )
    (local.set $Psubint_221
     (ref.i31
      (i32.const 5)
     )
    )
    (local.set $Pmakeblock_arg_222
     (block (result (ref eq))
      (local.set $call_result1#3
       (block (result i32)
        (local.set $scratch_57
         (tuple.extract 2 0
          (local.tee $scratch_56
           (call $tak_43
            (local.get $Psubint_221)
            (local.get $param_211)
            (local.get $param_215)
            (ref.cast (ref $Env)
             (local.get $tak_174)
            )
           )
          )
         )
        )
        (local.set $call_result2#4
         (tuple.extract 2 1
          (local.get $scratch_56)
         )
        )
        (local.get $scratch_57)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#3)
       (then
        (unreachable)
       )
       (else
        (local.get $call_result2#4)
       )
      )
     )
    )
    (local.set $Psubint_224
     (ref.i31
      (i32.const 10)
     )
    )
    (local.set $Pmakeblock_arg_225
     (block (result (ref eq))
      (local.set $call_result1#5
       (block (result i32)
        (local.set $scratch_59
         (tuple.extract 2 0
          (local.tee $scratch_58
           (call $tak_43
            (local.get $Psubint_224)
            (local.get $param_213)
            (local.get $param_211)
            (ref.cast (ref $Env)
             (local.get $tak_174)
            )
           )
          )
         )
        )
        (local.set $call_result2#6
         (tuple.extract 2 1
          (local.get $scratch_58)
         )
        )
        (local.get $scratch_59)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#5)
       (then
        (unreachable)
       )
       (else
        (local.get $call_result2#6)
       )
      )
     )
    )
    (local.set $Pmakeblock_arg_187
     (block (result (ref eq))
      (local.set $call_result1#7
       (block (result i32)
        (local.set $scratch_61
         (tuple.extract 2 0
          (local.tee $scratch_60
           (call $tak_43
            (local.get $Pmakeblock_arg_225)
            (local.get $Pmakeblock_arg_222)
            (local.get $Pmakeblock_arg_219)
            (ref.cast (ref $Env)
             (local.get $tak_174)
            )
           )
          )
         )
        )
        (local.set $call_result2#8
         (tuple.extract 2 1
          (local.get $scratch_60)
         )
        )
        (local.get $scratch_61)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#7)
       (then
        (unreachable)
       )
       (else
        (local.get $call_result2#8)
       )
      )
     )
    )
    (local.set $param_231
     (ref.i31
      (i32.const 6)
     )
    )
    (local.set $param_233
     (ref.i31
      (i32.const 12)
     )
    )
    (local.set $param_235
     (ref.i31
      (i32.const 17)
     )
    )
    (local.set $Psubint_238
     (ref.i31
      (i32.const 5)
     )
    )
    (local.set $Pmakeblock_arg_239
     (block (result (ref eq))
      (local.set $call_result1#9
       (block (result i32)
        (local.set $scratch_63
         (tuple.extract 2 0
          (local.tee $scratch_62
           (call $tak_43
            (local.get $Psubint_238)
            (local.get $param_235)
            (local.get $param_233)
            (ref.cast (ref $Env)
             (local.get $tak_174)
            )
           )
          )
         )
        )
        (local.set $call_result2#10
         (tuple.extract 2 1
          (local.get $scratch_62)
         )
        )
        (local.get $scratch_63)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#9)
       (then
        (unreachable)
       )
       (else
        (local.get $call_result2#10)
       )
      )
     )
    )
    (local.set $Psubint_241
     (ref.i31
      (i32.const 11)
     )
    )
    (local.set $Pmakeblock_arg_242
     (block (result (ref eq))
      (local.set $call_result1#11
       (block (result i32)
        (local.set $scratch_65
         (tuple.extract 2 0
          (local.tee $scratch_64
           (call $tak_43
            (local.get $Psubint_241)
            (local.get $param_231)
            (local.get $param_235)
            (ref.cast (ref $Env)
             (local.get $tak_174)
            )
           )
          )
         )
        )
        (local.set $call_result2#12
         (tuple.extract 2 1
          (local.get $scratch_64)
         )
        )
        (local.get $scratch_65)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#11)
       (then
        (unreachable)
       )
       (else
        (local.get $call_result2#12)
       )
      )
     )
    )
    (local.set $Psubint_244
     (ref.i31
      (i32.const 16)
     )
    )
    (local.set $Pmakeblock_arg_245
     (block (result (ref eq))
      (local.set $call_result1#13
       (block (result i32)
        (local.set $scratch_67
         (tuple.extract 2 0
          (local.tee $scratch_66
           (call $tak_43
            (local.get $Psubint_244)
            (local.get $param_233)
            (local.get $param_231)
            (ref.cast (ref $Env)
             (local.get $tak_174)
            )
           )
          )
         )
        )
        (local.set $call_result2#14
         (tuple.extract 2 1
          (local.get $scratch_66)
         )
        )
        (local.get $scratch_67)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#13)
       (then
        (unreachable)
       )
       (else
        (local.get $call_result2#14)
       )
      )
     )
    )
    (local.set $Pmakeblock_arg_189
     (block (result (ref eq))
      (local.set $call_result1#15
       (block (result i32)
        (local.set $scratch_69
         (tuple.extract 2 0
          (local.tee $scratch_68
           (call $tak_43
            (local.get $Pmakeblock_arg_245)
            (local.get $Pmakeblock_arg_242)
            (local.get $Pmakeblock_arg_239)
            (ref.cast (ref $Env)
             (local.get $tak_174)
            )
           )
          )
         )
        )
        (local.set $call_result2#16
         (tuple.extract 2 1
          (local.get $scratch_68)
         )
        )
        (local.get $scratch_69)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#15)
       (then
        (unreachable)
       )
       (else
        (local.get $call_result2#16)
       )
      )
     )
    )
    (local.set $Paddint_arg_190
     (block (result (ref eq))
      (local.set $call_result1#17
       (block (result i32)
        (local.set $scratch_71
         (tuple.extract 2 0
          (local.tee $scratch_70
           (call $tak_43
            (local.get $Pmakeblock_arg_189)
            (local.get $Pmakeblock_arg_187)
            (local.get $Pmakeblock_arg_185)
            (ref.cast (ref $Env)
             (local.get $tak_174)
            )
           )
          )
         )
        )
        (local.set $call_result2#18
         (tuple.extract 2 1
          (local.get $scratch_70)
         )
        )
        (local.get $scratch_71)
       )
      )
      (if (result (ref eq))
       (local.get $call_result1#17)
       (then
        (unreachable)
       )
       (else
        (local.get $call_result2#18)
       )
      )
     )
    )
    (local.set $Paddint_191
     (ref.i31
      (i32.add
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Paddint_arg_190)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $accu_169)
        )
       )
      )
     )
    )
    (local.set $Psubint_193
     (ref.i31
      (i32.const 19999)
     )
    )
    (local.set $apply_funct_194
     (global.get $camlTaku__repeat_49_closure)
    )
    (local.set $call_result1#19
     (block (result i32)
      (local.set $scratch_73
       (tuple.extract 2 0
        (local.tee $scratch_72
         (call $repeat_49
          (local.get $Psubint_193)
          (local.get $Paddint_191)
          (ref.cast (ref $Env)
           (local.get $apply_funct_194)
          )
         )
        )
       )
      )
      (local.set $call_result2#20
       (tuple.extract 2 1
        (local.get $scratch_72)
       )
      )
      (local.get $scratch_73)
     )
    )
    (if (result (ref eq))
     (local.get $call_result1#19)
     (then
      (unreachable)
     )
     (else
      (local.get $call_result2#20)
     )
    )
   )
  )
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlTaku__Pccall_144)
   )
   (i32.const 1)
   (block (result (ref eq))
    (local.set $Pccall_arg_146
     (global.get $camlStdlib__const_immstring_542)
    )
    (local.set $apply_arg_145
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlTaku__apply_arg_92)
      )
      (i32.const 1)
     )
    )
    (call $11_23
     (local.get $Pccall_arg_146)
     (local.get $apply_arg_145)
    )
   )
  )
  (drop
   (block (result (ref eq))
    (local.set $stdout_135
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__Pccall_1851)
      )
      (i32.const 1)
     )
    )
    (local.set $apply_funct_134
     (global.get $camlStdlib__output_string_763_closure)
    )
    (local.set $Pccall_147
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlTaku__Pccall_144)
      )
      (i32.const 1)
     )
    )
    (local.set $call_result1#21
     (block (result i32)
      (local.set $scratch_75
       (tuple.extract 2 0
        (local.tee $scratch_74
         (call $output_string_763
          (local.get $stdout_135)
          (local.get $Pccall_147)
          (ref.cast (ref $Env)
           (local.get $apply_funct_134)
          )
         )
        )
       )
      )
      (local.set $call_result2#22
       (tuple.extract 2 1
        (local.get $scratch_74)
       )
      )
      (local.get $scratch_75)
     )
    )
    (if (result (ref eq))
     (local.get $call_result1#21)
     (then
      (unreachable)
     )
     (else
      (local.get $call_result2#22)
     )
    )
   )
  )
 )
 (func $tak_43 (type $Func_3) (param $P_param_12 (ref eq)) (param $P_param_11 (ref eq)) (param $P_param_10 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#36 (ref eq))
  (local $call_result2#34 (ref eq))
  (local $call_result2#32 (ref eq))
  (local $call_result1#35 i32)
  (local $call_result1#33 i32)
  (local $call_result1#31 i32)
  (local $cond_15 (ref eq))
  (local $Psubint_arg_31 (ref eq))
  (local $Psubint_arg_24 (ref eq))
  (local $Psubint_arg_17 (ref eq))
  (local $Psubint_32 (ref eq))
  (local $Psubint_25 (ref eq))
  (local $Psubint_18 (ref eq))
  (local $Pmakeblock_arg_39 (ref eq))
  (local $Pmakeblock_arg_38 (ref eq))
  (local $Pmakeblock_arg_37 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_21 i32)
  (local $scratch_22 (tuple i32 (ref eq)))
  (local $scratch_23 i32)
  (local $scratch_24 (tuple i32 (ref eq)))
  (local $scratch_25 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $cond_15
     (ref.i31
      (i32.gt_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_param_12)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_param_11)
        )
       )
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $cond_15)
      )
     )
     (then
      (local.set $Psubint_arg_31
       (ref.i31
        (i32.const 1)
       )
      )
      (local.set $Psubint_32
       (ref.i31
        (i32.sub
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $P_param_10)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Psubint_arg_31)
          )
         )
        )
       )
      )
      (local.set $Pmakeblock_arg_37
       (block (result (ref eq))
        (local.set $call_result1#31
         (block (result i32)
          (local.set $scratch_21
           (tuple.extract 2 0
            (local.tee $scratch
             (call $tak_43
              (local.get $Psubint_32)
              (local.get $P_param_12)
              (local.get $P_param_11)
              (ref.cast (ref $Closure_3_0)
               (global.get $camlTaku__tak_43_closure)
              )
             )
            )
           )
          )
          (local.set $call_result2#32
           (tuple.extract 2 1
            (local.get $scratch)
           )
          )
          (local.get $scratch_21)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#31)
         (then
          (return
           (tuple.make 2
            (i32.const 1)
            (local.get $call_result2#32)
           )
          )
         )
         (else
          (local.get $call_result2#32)
         )
        )
       )
      )
      (local.set $Psubint_arg_24
       (ref.i31
        (i32.const 1)
       )
      )
      (local.set $Psubint_25
       (ref.i31
        (i32.sub
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $P_param_11)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Psubint_arg_24)
          )
         )
        )
       )
      )
      (local.set $Pmakeblock_arg_38
       (block (result (ref eq))
        (local.set $call_result1#33
         (block (result i32)
          (local.set $scratch_23
           (tuple.extract 2 0
            (local.tee $scratch_22
             (call $tak_43
              (local.get $Psubint_25)
              (local.get $P_param_10)
              (local.get $P_param_12)
              (ref.cast (ref $Closure_3_0)
               (global.get $camlTaku__tak_43_closure)
              )
             )
            )
           )
          )
          (local.set $call_result2#34
           (tuple.extract 2 1
            (local.get $scratch_22)
           )
          )
          (local.get $scratch_23)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#33)
         (then
          (return
           (tuple.make 2
            (i32.const 1)
            (local.get $call_result2#34)
           )
          )
         )
         (else
          (local.get $call_result2#34)
         )
        )
       )
      )
      (local.set $Psubint_arg_17
       (ref.i31
        (i32.const 1)
       )
      )
      (local.set $Psubint_18
       (ref.i31
        (i32.sub
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $P_param_12)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Psubint_arg_17)
          )
         )
        )
       )
      )
      (local.set $Pmakeblock_arg_39
       (block (result (ref eq))
        (local.set $call_result1#35
         (block (result i32)
          (local.set $scratch_25
           (tuple.extract 2 0
            (local.tee $scratch_24
             (call $tak_43
              (local.get $Psubint_18)
              (local.get $P_param_11)
              (local.get $P_param_10)
              (ref.cast (ref $Closure_3_0)
               (global.get $camlTaku__tak_43_closure)
              )
             )
            )
           )
          )
          (local.set $call_result2#36
           (tuple.extract 2 1
            (local.get $scratch_24)
           )
          )
          (local.get $scratch_25)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#35)
         (then
          (return
           (tuple.make 2
            (i32.const 1)
            (local.get $call_result2#36)
           )
          )
         )
         (else
          (local.get $call_result2#36)
         )
        )
       )
      )
      (return_call $tak_43
       (local.get $Pmakeblock_arg_39)
       (local.get $Pmakeblock_arg_38)
       (local.get $Pmakeblock_arg_37)
       (ref.cast (ref $Closure_3_0)
        (global.get $camlTaku__tak_43_closure)
       )
      )
     )
     (else
      (local.get $P_param_10)
     )
    )
   )
  )
 )
 (func $tak_8 (type $Func_1) (param $P_tak_44 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $param_47 (ref eq))
  (local $param_46 (ref eq))
  (local $param_45 (ref eq))
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block
    (local.set $param_47
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_tak_44)
      )
      (i32.const 3)
     )
    )
    (local.set $param_46
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_tak_44)
      )
      (i32.const 2)
     )
    )
    (local.set $param_45
     (array.get $Array
      (ref.cast (ref $Array)
       (local.get $P_tak_44)
      )
      (i32.const 1)
     )
    )
    (return_call $tak_43
     (local.get $param_45)
     (local.get $param_46)
     (local.get $param_47)
     (ref.cast (ref $Closure_3_0)
      (global.get $camlTaku__tak_43_closure)
     )
    )
   )
  )
 )
 (func $repeat_49 (type $Func_2) (param $P_n_53 (ref eq)) (param $P_accu_52 (ref eq)) (param $Env (ref $Env)) (result i32 (ref eq))
  (local $call_result2#30 (ref eq))
  (local $call_result2#28 (ref eq))
  (local $call_result2#26 (ref eq))
  (local $call_result2#24 (ref eq))
  (local $call_result1#29 i32)
  (local $call_result1#27 i32)
  (local $call_result1#25 i32)
  (local $call_result1#23 i32)
  (local $tak_119 (ref eq))
  (local $param_154 (ref eq))
  (local $param_152 (ref eq))
  (local $param_150 (ref eq))
  (local $apply_funct_70 (ref eq))
  (local $Psubint_arg_60 (ref eq))
  (local $Psubint_163 (ref eq))
  (local $Psubint_160 (ref eq))
  (local $Psubint_157 (ref eq))
  (local $Psubint_61 (ref eq))
  (local $Pmakeblock_arg_164 (ref eq))
  (local $Pmakeblock_arg_161 (ref eq))
  (local $Pmakeblock_arg_158 (ref eq))
  (local $Pintcomp_arg_56 (ref eq))
  (local $Pintcomp_57 (ref eq))
  (local $Paddint_arg_66 (ref eq))
  (local $Paddint_67 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_29 i32)
  (local $scratch_30 (tuple i32 (ref eq)))
  (local $scratch_31 i32)
  (local $scratch_32 (tuple i32 (ref eq)))
  (local $scratch_33 i32)
  (local $scratch_34 (tuple i32 (ref eq)))
  (local $scratch_35 i32)
  (tuple.make 2
   (block (result i32)
    (i32.const 0)
   )
   (block (result (ref eq))
    (local.set $Pintcomp_arg_56
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Pintcomp_57
     (ref.i31
      (i32.le_s
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $P_n_53)
        )
       )
       (i31.get_s
        (ref.cast (ref i31)
         (local.get $Pintcomp_arg_56)
        )
       )
      )
     )
    )
    (if (result (ref eq))
     (i31.get_s
      (ref.cast (ref i31)
       (local.get $Pintcomp_57)
      )
     )
     (then
      (local.get $P_accu_52)
     )
     (else
      (local.set $tak_119
       (global.get $camlTaku__tak_43_closure)
      )
      (local.set $param_150
       (ref.i31
        (i32.const 6)
       )
      )
      (local.set $param_152
       (ref.i31
        (i32.const 12)
       )
      )
      (local.set $param_154
       (ref.i31
        (i32.const 18)
       )
      )
      (local.set $Psubint_157
       (ref.i31
        (i32.const 5)
       )
      )
      (local.set $Pmakeblock_arg_158
       (block (result (ref eq))
        (local.set $call_result1#23
         (block (result i32)
          (local.set $scratch_29
           (tuple.extract 2 0
            (local.tee $scratch
             (call $tak_43
              (local.get $Psubint_157)
              (local.get $param_154)
              (local.get $param_152)
              (ref.cast (ref $Env)
               (local.get $tak_119)
              )
             )
            )
           )
          )
          (local.set $call_result2#24
           (tuple.extract 2 1
            (local.get $scratch)
           )
          )
          (local.get $scratch_29)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#23)
         (then
          (return
           (tuple.make 2
            (i32.const 1)
            (local.get $call_result2#24)
           )
          )
         )
         (else
          (local.get $call_result2#24)
         )
        )
       )
      )
      (local.set $Psubint_160
       (ref.i31
        (i32.const 11)
       )
      )
      (local.set $Pmakeblock_arg_161
       (block (result (ref eq))
        (local.set $call_result1#25
         (block (result i32)
          (local.set $scratch_31
           (tuple.extract 2 0
            (local.tee $scratch_30
             (call $tak_43
              (local.get $Psubint_160)
              (local.get $param_150)
              (local.get $param_154)
              (ref.cast (ref $Env)
               (local.get $tak_119)
              )
             )
            )
           )
          )
          (local.set $call_result2#26
           (tuple.extract 2 1
            (local.get $scratch_30)
           )
          )
          (local.get $scratch_31)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#25)
         (then
          (return
           (tuple.make 2
            (i32.const 1)
            (local.get $call_result2#26)
           )
          )
         )
         (else
          (local.get $call_result2#26)
         )
        )
       )
      )
      (local.set $Psubint_163
       (ref.i31
        (i32.const 17)
       )
      )
      (local.set $Pmakeblock_arg_164
       (block (result (ref eq))
        (local.set $call_result1#27
         (block (result i32)
          (local.set $scratch_33
           (tuple.extract 2 0
            (local.tee $scratch_32
             (call $tak_43
              (local.get $Psubint_163)
              (local.get $param_152)
              (local.get $param_150)
              (ref.cast (ref $Env)
               (local.get $tak_119)
              )
             )
            )
           )
          )
          (local.set $call_result2#28
           (tuple.extract 2 1
            (local.get $scratch_32)
           )
          )
          (local.get $scratch_33)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#27)
         (then
          (return
           (tuple.make 2
            (i32.const 1)
            (local.get $call_result2#28)
           )
          )
         )
         (else
          (local.get $call_result2#28)
         )
        )
       )
      )
      (local.set $Paddint_arg_66
       (block (result (ref eq))
        (local.set $call_result1#29
         (block (result i32)
          (local.set $scratch_35
           (tuple.extract 2 0
            (local.tee $scratch_34
             (call $tak_43
              (local.get $Pmakeblock_arg_164)
              (local.get $Pmakeblock_arg_161)
              (local.get $Pmakeblock_arg_158)
              (ref.cast (ref $Env)
               (local.get $tak_119)
              )
             )
            )
           )
          )
          (local.set $call_result2#30
           (tuple.extract 2 1
            (local.get $scratch_34)
           )
          )
          (local.get $scratch_35)
         )
        )
        (if (result (ref eq))
         (local.get $call_result1#29)
         (then
          (return
           (tuple.make 2
            (i32.const 1)
            (local.get $call_result2#30)
           )
          )
         )
         (else
          (local.get $call_result2#30)
         )
        )
       )
      )
      (local.set $Paddint_67
       (ref.i31
        (i32.add
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Paddint_arg_66)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $P_accu_52)
          )
         )
        )
       )
      )
      (local.set $Psubint_arg_60
       (ref.i31
        (i32.const 1)
       )
      )
      (local.set $Psubint_61
       (ref.i31
        (i32.sub
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $P_n_53)
          )
         )
         (i31.get_s
          (ref.cast (ref i31)
           (local.get $Psubint_arg_60)
          )
         )
        )
       )
      )
      (local.set $apply_funct_70
       (global.get $camlTaku__repeat_49_closure)
      )
      (return_call $repeat_49
       (local.get $Psubint_61)
       (local.get $Paddint_67)
       (ref.cast (ref $Env)
        (local.get $apply_funct_70)
       )
      )
     )
    )
   )
  )
 )
 (func $merged.start.new_333 (type $22)
  (call $R_not_really_start_321)
 )
 (func $R_not_really_start_335 (type $22)
  (local $Indirec_call_closure_1 (ref $Env))
  (local $call_result2#2 (ref eq))
  (local $call_result1#1 i32)
  (local $simplify_fv_29 (ref eq))
  (local $r_28 (ref eq))
  (local $apply_arg_20 (ref eq))
  (local $scratch (tuple i32 (ref eq)))
  (local $scratch_7 i32)
  (array.set $Array
   (ref.cast (ref $Array)
    (global.get $camlStd_exit__simplify_fv_27)
   )
   (i32.const 1)
   (block (result (ref eq))
    (local.set $r_28
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStdlib__exit_function_1810)
      )
      (i32.const 1)
     )
    )
    (array.get $Array
     (ref.cast (ref $Array)
      (local.get $r_28)
     )
     (i32.const 1)
    )
   )
  )
  (drop
   (block (result (ref eq))
    (local.set $simplify_fv_29
     (array.get $Array
      (ref.cast (ref $Array)
       (global.get $camlStd_exit__simplify_fv_27)
      )
      (i32.const 1)
     )
    )
    (local.set $apply_arg_20
     (ref.i31
      (i32.const 0)
     )
    )
    (local.set $Indirec_call_closure_1
     (ref.cast (ref $Env)
      (local.get $simplify_fv_29)
     )
    )
    (local.set $call_result1#1
     (block (result i32)
      (local.set $scratch_7
       (tuple.extract 2 0
        (local.tee $scratch
         (call_ref $Func_1
          (local.get $apply_arg_20)
          (local.get $Indirec_call_closure_1)
          (struct.get $Env 1
           (local.get $Indirec_call_closure_1)
          )
         )
        )
       )
      )
      (local.set $call_result2#2
       (tuple.extract 2 1
        (local.get $scratch)
       )
      )
      (local.get $scratch_7)
     )
    )
    (if (result (ref eq))
     (local.get $call_result1#1)
     (then
      (unreachable)
     )
     (else
      (local.get $call_result2#2)
     )
    )
   )
  )
 )
 (func $merged.start.old_337 (type $22)
  (block
   (block
    (block
     (call $R_not_really_start)
     (call $merged.start.new)
    )
    (call $merged.start.new_319)
   )
   (call $merged.start.new_333)
  )
  (call $merged.start.new_337)
 )
 (func $merged.start.new_337 (type $22)
  (call $R_not_really_start_335)
 )
)
