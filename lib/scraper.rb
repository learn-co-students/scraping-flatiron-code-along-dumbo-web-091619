require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
  def get_page
    html = open("https://flatironschool.com/")
    page = Nokogiri::HTML(html)
  end

  def get_courses
    page = get_page
    courses = page.css("#2a778efd-1685-5ec6-9e5a-0843d6a88b7b .inlineMobileLeft-2Yo002.imageTextBlockGrid3-2XAK6G")
  end

  def make_courses
    page = get_page
    courses = get_courses
    courses.each do |course|
      new_course = Course.new
      new_course.title = course.css('h2').text
      new_course.schedule = course.css('date').text
      new_course.description = course.css('p').text
    end
  end

end



