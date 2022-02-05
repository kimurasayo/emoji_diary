module LoginModule
  def Login_as(user)
    visit root_path
    click_link 'login'
    fill_in "email", with: user.email
    fill_in "password", with: 'password'
    click_button "login"
  end
end
