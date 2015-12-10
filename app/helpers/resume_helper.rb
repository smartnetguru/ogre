module ResumeHelper
  def surround_with_box(inside, width)
    padding = (width - 2 - inside.length)
    retval = ""
    retval += "." + "="*(width-2) + "."
    retval += "\n"
    retval += "|"
    retval += inside
    retval += " "*padding + "|"
    retval += "\n"
    retval += "˙" + "="*(width-2) + "˙"
    retval += "\n"
    return retval
  end
end
