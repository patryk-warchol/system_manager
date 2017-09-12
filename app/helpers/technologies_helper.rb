module TechnologiesHelper

  def put_technology(technology)

    html_elt = ""
    html_elt << "<td>" + technology.name + "</td>"
   
    version = `#{technology.get_cmd}`

    if $?.exitstatus.to_s != "0"
      version = "Not found"
      html_elt << "<td><span class=\"label label-danger\">" + version + "</span></td>"
    elsif version == "" || version.nil?
      version = "Error"
      html_elt << "<td><span class=\"label label-default\">" + version + "</span></td>"
    else
      html_elt << "<td><span class=\"label label-success\">" + version + "</span></td>"
    end

    return html_elt.html_safe

  end

end
