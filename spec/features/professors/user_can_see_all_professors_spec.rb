require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
    @hagarid = Professor.create(name: "Rubus Hagarid", age: 38 , specialty: "Care of Magical Creatures")
    @lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

    @harry = Student.create(name: "Harry Potter" , age: 11 , house: "Gryffindor" )
    @malfoy = Student.create(name: "Draco Malfoy" , age: 12 , house: "Slytherin" )
    @longbottom = Student.create(name: "Neville Longbottom" , age: 11 , house: "Gryffindor" )

    ProfessorStudent.create(student: @harry, professor: @snape)
    ProfessorStudent.create(student: @harry, professor: @hagarid)
    ProfessorStudent.create(student: @harry, professor: @lupin)
    ProfessorStudent.create(student: @malfoy, professor: @hagarid)
    ProfessorStudent.create(student: @malfoy, professor: @lupin)
    ProfessorStudent.create(student: @longbottom, professor: @snape)
  end
  describe "When I visit /professors"
  it "I see a list of professors and their info" do
    visit '/professors'

    expect(page).to have_content("Severus Snape")
    expect(page).to have_content("Rubus Hagarid")
    expect(page).to have_content("Remus Lupin")


    within "#professor-info-#{@snape.id}" do
      expect(page).to have_content("Name: Severus Snape")
      expect(page).to have_content("Age: 45")
      expect(page).to have_content("Specialty: Potions")
    end
  end
  describe "When I visit /professors/:id"
  it "I see a list of names of the students the professors have" do
    visit "/professors/#{@snape.id}"

    expect(page).to have_content(@harry.name)
    expect(page).to have_content(@longbottom.name)
    expect(page).to_not have_content(@malfoy.name)
  end
end
