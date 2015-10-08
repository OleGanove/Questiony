module UsersHelper
  def get_gender(number = "4")
  	case number
  	  when "1" then 'female'
  	  when "2" then 'male'
  	  when "3" then 'other'
  	  when "4" then 'not specified'
  	  when ""  then 'not specified'
  	end
  end
end
