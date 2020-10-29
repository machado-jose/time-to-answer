module ApplicationHelper
  def translate_atrribute(object = nil, method = nil)
    (object && method) ? object.model.human_attribute_name(method) : "Informe os parâmetros corretamente"
  end

  def welcome_message_with_name(object = nil)
    if object
      if !object.full_name.strip.empty?
        t('messages.welcome_to', item: object.full_name )
      elsif !object.first_name.empty?
        t('messages.welcome_to', item: object.first_name )
      else
        t('messages.welcome_to', item: object.email )
      end
    end
  end

  def check_and_get_name(object = nil)
    if object
      if !object.full_name.strip.empty?
        object.full_name
      elsif !object.first_name.empty?
        object.first_name
      else
        object.email
      end
    end
  end
end
