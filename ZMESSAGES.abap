*&---------------------------------------------------------------------*
*&  Include           ZMESSAGES
*&---------------------------------------------------------------------*
* #SRG 05/06/2012. Include con rutinas para gestionar los mensajes
* usando el módulo de funciones SMSG.
*
* 1) Ejecutamos PERFORM messages_active.
* 2) Vamos introduciendo los mensajes com PERFORM message_store ...
* Ejemplo1:
*       Mensaje de Error de la Clase ZBAS
*      "Campo '&' es obligatorio.
*      PERFORM message_store USING 'E' 'ZBAS' '003'  'Número de envío' '' '' ''.
*
* Ejemplo2:
*    Mensaje desde error "estandar".
*    IF sy-subrc <> 0.
*      PERFORM message_store USING sy-msgty sy-msgid sy-msgno sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
*    ELSE.
* 3) Los mostramos PERFORM messages_show.
*
*
data: gl_message_exist type c."Si se ha insertado algún mensaje.
*&---------------------------------------------------------------------*
*&      Form  message_store
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_MSGTY    text
*      -->P_ARBGB    text
*      -->P_TXTNR    text
*      -->P_MSGV1    text
*      -->P_MSGV2    text
*      -->P_MSGV3    text
*      -->P_MSGV4    text
*----------------------------------------------------------------------*
form message_store using p_msgty p_arbgb p_txtnr p_msgv1 p_msgv2 p_msgv3 p_msgv4.
*
  gl_message_exist = 'X'.
*
  call function 'MESSAGE_STORE'
    exporting
      arbgb                         = p_arbgb
*   EXCEPTION_IF_NOT_ACTIVE       = 'X'
      msgty                         = p_msgty
      msgv1                         = p_msgv1
      msgv2                         = p_msgv2
      msgv3                         = p_msgv3
      msgv4                         = p_msgv4
      txtnr                         = p_txtnr.
*
endform.                    "message_store


*&---------------------------------------------------------------------*
*&      Form  messages_active
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
form messages_active.
*
  clear gl_message_exist.
  call function 'MESSAGES_INITIALIZE'.
*
endform.                    "messages_active

*&---------------------------------------------------------------------*
*&      Form  MESSAGES_SHOW
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
form messages_show.
  if gl_message_exist is not initial.
    call function 'MESSAGES_SHOW'.
  endif.
  clear gl_message_exist.
endform.                    "MESSAGES_SHOW
