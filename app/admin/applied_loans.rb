ActiveAdmin.register AppliedLoan do

  config.filters = false
  scope :all, default: true
  scope :pending
  scope :approved
  scope :rejected

  index do
    column :email
    column :credit_limit
    column "System Recommendation" do |n|
      n.creditbility_score > 0 ? "Approve" : "REJECT" 
    end
    column :actions do |applied_loan|
      links = []
      links << link_to('Approve', approve_admin_applied_loan_path(applied_loan), method: :put, :data => {:confirm => 'Are you sure you want to approve the application?'}) if applied_loan.status == "pending"
      links << link_to('Reject', approve_admin_applied_loan_path(applied_loan), method: :put, :data => {:confirm => 'Are you sure you want to reject the application?'}) if applied_loan.status == "pending"
      links.join(' ').html_safe
     end 

  end

  member_action :approve, method: :put do
    resource.approve!
    redirect_to admin_applied_loans_path
  end
     
  member_action :reject, method: :put do
    resource.reject!
    redirect_to admin_applied_loans_path
  end

end
