format 74

classinstance 128002 class_ref 142722 // ChatController
  name ""   xyz 132 4 2000 life_line_z 2000
classinstance 128514 class_ref 141570 // Chat
  name ""   xyz 271 4 2000 life_line_z 2000
durationcanvas 128130 classinstance_ref 128002 // :ChatController
  xyzwh 175 48 2010 11 90
end
durationcanvas 128642 classinstance_ref 128514 // :Chat
  xyzwh 290 63 2010 11 25
end
durationcanvas 129282 classinstance_ref 128002 // :ChatController
  xyzwh 175 178 2010 11 177
  overlappingdurationcanvas 130946
    xyzwh 181 325 2020 11 25
  end
end
durationcanvas 129666 classinstance_ref 128514 // :Chat
  xyzwh 290 102 2010 11 25
end
durationcanvas 129922 classinstance_ref 128514 // :Chat
  xyzwh 290 188 2010 11 25
end
durationcanvas 130178 classinstance_ref 128514 // :Chat
  xyzwh 290 221 2010 11 25
end
durationcanvas 130434 classinstance_ref 128514 // :Chat
  xyzwh 290 250 2010 11 25
end
durationcanvas 130690 classinstance_ref 128514 // :Chat
  xyzwh 290 281 2010 11 25
end
lostfoundmsgsupport 128258 xyz 18 50 2015
lostfoundmsgsupport 129410 xyz 11 180 2015
msg 128386 found_synchronous
  from lostfoundmsgsupport_ref 128258
  to durationcanvas_ref 128130
  yz 48 2015 msg operation_ref 149378 // "list_pendiente()"
  show_full_operations_definition default drawing_language default show_context_mode default
  args "params[]"
  label_xy 22 31
msg 128770 synchronous
  from durationcanvas_ref 128130
  to durationcanvas_ref 128642
  yz 69 2020 msg operation_ref 149634 // "pendientes()"
  show_full_operations_definition default drawing_language default show_context_mode default
  label_xy 203 52
msg 129538 found_synchronous
  from lostfoundmsgsupport_ref 129410
  to durationcanvas_ref 129282
  yz 178 2015 msg operation_ref 149506 // "tomar()"
  show_full_operations_definition default drawing_language default show_context_mode default
  args "params[]"
  label_xy 51 161
msg 129794 synchronous
  from durationcanvas_ref 128130
  to durationcanvas_ref 129666
  yz 102 2015 msg operation_ref 135682 // "paginate(in page : int, in order : string)"
  show_full_operations_definition default drawing_language default show_context_mode default
  label_xy 209 85
msg 130050 synchronous
  from durationcanvas_ref 129282
  to durationcanvas_ref 129922
  yz 192 2020 msg operation_ref 135298 // "find()"
  show_full_operations_definition default drawing_language default show_context_mode default
  label_xy 223 175
msg 130306 synchronous
  from durationcanvas_ref 129282
  to durationcanvas_ref 130178
  yz 224 2015 explicitmsg "operador_id"
  show_full_operations_definition default drawing_language default show_context_mode default
  args "session[:usuario][:id]"
  label_xy 204 207
msg 130562 synchronous
  from durationcanvas_ref 129282
  to durationcanvas_ref 130434
  yz 251 2015 explicitmsg "estado_id"
  show_full_operations_definition default drawing_language default show_context_mode default
  label_xy 210 234
msg 130818 synchronous
  from durationcanvas_ref 129282
  to durationcanvas_ref 130690
  yz 282 2020 msg operation_ref 135426 // "save()"
  show_full_operations_definition default drawing_language default show_context_mode default
  label_xy 221 265
reflexivemsg 131074 synchronous
  to durationcanvas_ref 130946
  yz 325 2025 msg operation_ref 142210 // "render()"
  show_full_operations_definition default drawing_language default show_context_mode default
  args "render :action => 'init'"
  label_xy 191 308
end
