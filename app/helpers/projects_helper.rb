module ProjectsHelper

  def put_project(project)

    html_elt = ""
    html_elt << "<td>" + project.name + "</td>"

    port_process_pids = `lsof -i tcp:#{project.port} -t`
    
    running = false

    # verificate if process run
    if port_process_pids.nil? || port_process_pids == ""
      # process on the given port doesn't exists
    else
      # process run, list of port and loop on each port
      `lsof -i tcp:#{project.port} -t`.gsub(/\s+/m, ' ').strip.split(" ").each do |port|
        # grep with term_for_grep
        ps_port_grep_res = `ps -p #{port} -o comm= | grep "#{project.term_for_grep}"`
        if $?.exitstatus.to_s == "0"
          # success
          if ps_port_grep_res.nil? || ps_port_grep_res == ""
            # null
          else
            # process with term_for_grep found
            running = true
          end
        else
          # command failed
        end
      end
    end
    # end 

    if running
      html_elt << "<td><span class=\"label label-success\">Running</span></td>"
    else
      html_elt << "<td><span class=\"label label-default\">Not running</span></td>"
    end

    html_elt << "<td>" + project.port + "</td>"

    if running
      html_elt << "<td>Stop</td>"
    else
      html_elt << "<td>Start</td>"
    end

    return html_elt.html_safe

  end
=begin
  verify if process on port 3000 exists
  
      lsof -i tcp:3000 -t
  
      if result == ""
      process don't exists -> run
      else
      process run -> kill
  
    kill process on port 3000
  
    kill -9 $(lsof -i tcp:3000 -t) 
  
    lsof -i tcp:3000 -t
    then
    ps -p 79593 -o comm=
    then
    grep "puma"
    if result == ""
    don't kill process
    else 
    kill process
=end
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
