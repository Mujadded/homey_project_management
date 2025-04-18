module ProjectsHelper
  def status_color(status)
    case status
    when "Draft"
      "bg-gray-200 text-gray-800 border border-gray-300"
    when "In Progress"
      "bg-blue-100 text-blue-800 border border-blue-300"
    when "Blocked"
      "bg-red-100 text-red-800 border border-red-300"
    when "Completed"
      "bg-green-100 text-green-800 border border-green-300"
    else
      "bg-gray-200 text-gray-800 border border-gray-300"
    end
  end
end
