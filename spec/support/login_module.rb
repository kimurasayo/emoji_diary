module LoginModule
  def Login_as(user)
    visit root_path
    click_link 'login'
    fill_in "user name", with: user.name
    fill_in "password", with: 'password'
    click_button "login"
  end
end
