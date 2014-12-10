require 'spec_helper'

describe "MicropostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
  	before { visit root_path }

  	describe "with invalid information" do

  		it "should not create a micropost" do
  			expect{ click_button "Post" }.not_to change(Micropost, :count)
  		end

  		describe "error messages" do
  			before { click_button "Post" }
  			it { should have_content('error') }
  		end
  	end

  	describe "with valid information" do
  		before { fill_in 'micropost_content', with: "Lorem ipsum" }
  		it "should create a micropost" do
  			expect{ click_button "Post" }.to change(Micropost, :count).by(1)
  		end
  	end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end

    describe "as wrong user" do
    	let(:wrong_user) { FactoryGirl.create(:user, email: "wronguser@example.com") }
	    let!(:m1) { FactoryGirl.create(:micropost, user: wrong_user, content: "Foo") }
	    let!(:m2) { FactoryGirl.create(:micropost, user: wrong_user, content: "Bar") }

	    before { visit user_path(wrong_user) }

	    describe "should see all micropost but delete link" do
		    it { should have_content(wrong_user.name) }
		    it { should have_title(wrong_user.name) }
	    	it { should have_content(m1.content) }
	    	it { should have_content(m2.content) }
	    	it { should have_content(wrong_user.microposts.count) }
			it { should_not have_link('delete', href: micropost_path(m1)), method: :delete }
		end
    end
  end
end
