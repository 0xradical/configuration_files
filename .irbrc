IRB.conf[:PROMPT][:CUSTOM] = {
  :RETURN      => "=> %s\n",
  :PROMPT_I    => "%03n:%i> ",
  :PROMPT_N    => "%03n:%i> ",
  :PROMPT_S    => "%03n:%i%l ",
  :PROMPT_C    => "%03n:%i* "
}

IRB.conf[:PROMPT_MODE] = :CUSTOM