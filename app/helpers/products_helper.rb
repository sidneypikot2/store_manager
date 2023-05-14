module ProductsHelper

  def input_label_class(has_error)
    if !has_error
      "block mb-2 text-sm font-semibold text-gray-900 light:text-white"
    else
      "block mb-2 text-sm font-semiboldtext-red-700 light:text-red-500"
    end
  end

  def input_text_class(has_error)
    if !has_error
      "bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 light:bg-gray-700 light:border-gray-600 light:placeholder-gray-400 light:text-white light:focus:ring-blue-500 light:focus:border-blue-500"
    else
      "bg-red-50 border border-red-500 text-red-900 placeholder-red-700 text-sm rounded-lg focus:ring-red-500 light:bg-gray-700 focus:border-red-500 block w-full p-2.5 light:text-red-500 light:placeholder-red-500 light:border-red-500"
    end
  end

  def display_error_message(model, key)
    if model.errors.include?(key)
      "<p class='mt-2 text-sm text-red-600 light:text-red-500'><span class='font-medium'>#{model.errors.full_messages_for(key)[0]}</span></p>".html_safe
    end
  end
end
