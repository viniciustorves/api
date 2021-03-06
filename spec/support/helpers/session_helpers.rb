module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: confirmation
      click_button 'Sign up'
    end

    def signin(email, password)
      post '/api/v1/staff/sign_in', staff: { email: email, password: password }
    end
  end
end
