require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'A Post' do
  before(:each) do
    setup_db
    @user = User.create!
    @post = Post.create!
  end
  
  after(:each) do
    teardown_db
  end
  
  it 'should have been created by an user' do
    @post.creator.reload.should == @user
    @post.updater.should be_nil
  end
  
  it 'should have been updated by an user' do
    @post.update_attributes :content => 'content'
    @post.creator.reload.should == @user
    @post.updater.reload.should == @user
  end
end

describe 'A Comment' do
  before(:each) do
    setup_db
    @person = Person.create!
    @comment = Comment.create!
  end
  
  after(:each) do
    teardown_db
  end
  
  it 'should have been created by a person' do
    @comment.creator.reload.should == @person
    @comment.updater.should be_nil
  end
  
  it 'should have been updated by a person' do
    @comment.update_attributes :content => 'content'
    @comment.creator.reload.should == @person
    @comment.updater.reload.should == @person
  end
end
