module ApplicationHelper

  def parse_followings_activities(array_of_openstruct_objects)
    array_of_openstruct_objects.group_by do |oso|
      oso.person
    end
  end

end


 
