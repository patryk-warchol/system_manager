module ProjectsHelper

  def put_project(project)
  
    html_elt = ""
    html_elt << "<td>" + project.name + "</td>"

    running = false

    list_of_processes = []

    # list of processes for project_name
    `ps aux | grep #{project.name} | awk '{print $2}'`.split("\n").each do |process_pid|
      list_of_processes << process_pid
    end

    # if a process contain term_for_grep then the process is running
    list_of_processes.each do |process_pid|
      `ps -p #{process_pid}`
      if $?.exitstatus.to_s == "0"
        if `ps -p #{process_pid} | grep #{project.term_for_grep}`
          # process with term_for_grep found
          running = true
        end
      end
    end

    if running
      html_elt << "<td><span class=\"label label-success\">Running</span></td>"
    else
      html_elt << "<td><span class=\"label label-default\">Not running</span></td>"
    end

    html_elt << "<td>" + project.port + "</td>"

    if running
      html_elt << stop_project_elt(project)
      # glyphicon glyphicon-remove
    else
      html_elt << start_project_elt(project)
      # glyphicon glyphicon-off
    end

    return html_elt.html_safe

  end

  def start_project_elt(project)
    html_elt = ""
    #html_elt << "<td>" + eval("link_to \"Start\", { controller: \"projects\", action: \"start_project\", id: project.id}, class: \"label label-success\" ") + "</td>"
    html_elt << "<td></td>"
    return html_elt
  end

  def stop_project_elt(project)
    html_elt = ""
    html_elt << "<td>" + eval("link_to \"Stop\", { controller: \"projects\", action: \"stop_project\", id: project.id}, class: \"label label-danger\" ") + "</td>"
    return html_elt
  end

end
