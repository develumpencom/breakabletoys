module ApplicationHelper
  def flash_classes(flash_type)
    "py-2 px-3 mb-5 font-medium rounded-lg inline-block " +

    class_names({
      "bg-green-50 text-green-500": flash_type == "notice",
      "bg-red-50 text-red-500": flash_type == "alert"
    })
  end
end
