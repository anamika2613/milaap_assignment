class AppliedLoan < ApplicationRecord

  before_save :set_credit_limit, :set_creditbility_score

  scope :pending, ->{where(status: 'pending')}
  scope :approved, ->{where(status: 'approved')}
  scope :rejected, ->{where(status: 'rejected')}

  def approve!
  	self.update_attribute(:status, 'approved')
  end

  def reject!
  	self.update_attribute(:status, 'rejected')
  end

  private 

  def set_credit_limit
    maximum_possible_emi = (monthly_recurring_inflow/2 - monthly_recurring_outflow)
    self.credit_limit = maximum_possible_emi * terms_in_months(maximum_possible_emi)
  end  

  def terms_in_months maximum_possible_emi
    if maximum_possible_emi >=0 && maximum_possible_emi <=5000 
      6 
    elsif maximum_possible_emi >=5001 && maximum_possible_emi <=10000 
      12 
    elsif maximum_possible_emi >=10001 && maximum_possible_emi <=20000 
      18
    else 
      0
    end  	
  end

  def set_creditbility_score
  	score  = begin
  	  response = CurlRequest.new(url: "https://api.fullcontact.com/v2/person.json", email: email).get
  	  calculate_credit_score response	
  	rescue StandardError => e
  	  0 
  	end
    score = score + 1 if AppliedLoan.exists?(email: self.email, status: "approved") 
    self.creditbility_score = score                 
  end

  def calculate_credit_score response
  	 score = 0 
  	 social_profiles = response.with_indifferent_access["socialProfiles"] ? response.with_indifferent_access["socialProfiles"] : []
     
     social_profiles.each do |social_profile| 
       social_profile_type_name = social_profile["typeName"] 
       case social_profile_type_name
	   when ->(val) {val=="LinkedIn"}
	       score = score + 1 	
	   when ->(val) {val=="Twitter"}
	       score = score + 1 
	   when ->(val) {val=="Facebook"}
	       score = score + 1 
	   end
     end
    score                          
  end



end
