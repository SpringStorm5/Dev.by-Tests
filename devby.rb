# coding: utf-8
require 'capybara' 
require 'capybara/dsl' 

include Capybara::DSL

Capybara.current_driver = :selenium
module MyModule

  class Registrator

	def login(login)
      @login = login
  end

  def email(email)
    @email = email
  end

    def rules_agree 
    Capybara.visit('http://dev.by/registration')
    find('.data-agreement > label:nth-child(2)').click
    end

    def form_filling  

      Capybara.fill_in('user_username', :with => @login)
      Capybara.fill_in('user_email', :with => @email)
      Capybara.fill_in('user_password', :with => '123456qwerty')
      Capybara.fill_in('user_password_confirmation', :with => '123456qwerty')      
      Capybara.fill_in('user_first_name', :with => '123')
      Capybara.fill_in('user_last_name', :with => '12')
      Capybara.fill_in('user_current_position', :with => '1992')
      Capybara.click_on('Выберите компанию')
      sleep 1
      Capybara.find(:xpath, "//body").find('.select2-drop li:first-child').click
      Capybara.click_on('Зарегистрироваться')

            
    end

    def nick_generate
      Capybara.visit('http://nick-name.ru/generate/')
      Capybara.click_on('Генерировать')
      return Capybara.find_field('resname').value
    end

  def email_generate
  Capybara.visit 'http://www.fakeinbox.com/'
  Capybara.find('#random input ').click
  return Capybara.find_field('mail').value 
  end

  def email_regenerate
  Capybara.visit 'http://www.fakeinbox.com/'
  Capybara.click_on('Delete E-mail Address')
  Capybara.find('#random input ').click
  return Capybara.find_field('mail').value 
  end
  
  def email_confirm
  sleep 10
  Capybara.visit 'http://www.fakeinbox.com/'
  sleep 5
  Capybara.click_on('Show')
  sleep 5
  Capybara.click_on('http://dev.by')
  end
    
  end
end

t = MyModule::Registrator.new
logins = []

puts 'Enter a number of registration users'
numberOfUsers = gets.chomp

i=0
while i < numberOfUsers.to_i
  login =t.nick_generate + 'unique'
  if (i==0)
    email =t.email_generate
  else email =t.email_regenerate
  end
  t.login(login)
  t.email(email)
  t.rules_agree
  t.form_filling
  t.email_confirm  
  logins = logins + [login + ' ' + email]
  i+=1
end

puts logins