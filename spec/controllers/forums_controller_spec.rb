require 'spec_helper'

describe ForumsController do

  describe "GET index" do

    it 'should render successfully' do
      get 'index'
      response.should be_success
    end

    it 'should find all forums' do
      Forum.stub!(:all).and_return([''])
      get 'index'
      assigns[:forums].should have(1).forum
    end
  end

  describe "GET edit" do
    it 'should find the forum with the id' do
      forum = Forum.new
      Forum.stub!(:find).with(1).and_return(forum)
      get 'edit', :id => 1
      assigns[:forum].should == forum
    end
  end

  describe "PUT 'update'" do
      before do
        @forum = Forum.new
        @forum_mock = mock("forum").as_null_object
        Forum.stub!(:find).and_return(@forum_mock)
      end
      it "should redirect to the index if the save is successful" do
        @forum_mock.stub!(:save).and_return(true)

        put 'update', :id => 1
        response.should redirect_to forums_path
      end

      it 'should load the forum for the given id' do
        Forum.stub!(:find).with(1).and_return(@forum)

        put 'update', :id => 1

        assigns[:forum].should == @forum
      end

      it 'should render edit if the save failed' do
        @forum_mock.stub!(:save).and_return(false)

        put 'update', :id => 1

        response.should render_template 'forums/edit'

      end

      it 'should update forum from params' do
        @forum.should_receive(:update_attributes).with('name' => 'test', 'description' => 'text').and_return(@forum_mock)
        Forum.stub!(:find).and_return(@forum)
        put 'update', :id =>1, :forum => {:name => 'test', :description => 'text'}
      end

      it 'should set the flash message on success' do
        @forum_mock.stub!(:save).and_return(true)

        put 'update', :id => 1

        flash[:notice].should == 'Forum updated'
      end
    end

  describe "DELETE destroy" do
    before do
      @forum = Forum.new
    end
    it 'should redirect to index when the destroy is successful' do
      Forum.stub!(:find).and_return(@forum)
      delete 'destroy', :id => 1
      response.should redirect_to forums_path
    end

    it 'should find the forum with the given id' do
      Forum.stub!(:find).with(1).and_return(@forum)
      delete 'destroy', :id => 1
      assigns[:forum].should == @forum
    end

    it 'should render a flash notice on success' do
      Forum.stub!(:find).and_return(@forum)
      delete 'destroy', :id => 1
      flash[:notice].should == 'Forum deleted'
    end

  end
end
