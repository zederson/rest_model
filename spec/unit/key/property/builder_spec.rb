require 'spec_helper'

describe RestModel::Property::Builder do
  shared_examples_for "a property" do
    it "defines an attr_accessor with property name" do
      Example.new.tap do |example|
        example.respond_to?("#{field}").should be_true
        example.respond_to?("#{field}=").should be_true
      end
    end

    it "puts a new property in keys list" do
      Example.keys.find {|key| key.name == field}.name.should == field
    end

    it "supports option definition" do
      Example.keys.find {|key| key.name == field}.options.should == options
    end
  end

  shared_examples_for "a key" do
    it "is referenced as the resource id" do
      Example.id_key.name.should == field
    end
  end

  describe ".id" do
    context "when it's just 'id'" do
      before do
        class Example < RestModel
          id
        end
      end

      let(:field)   {:id}
      let(:options) {{id: true, validate: true}}

      it_behaves_like "a property"
      it_behaves_like "a key"
    end

    context "when it has a different name" do
      before do
        class Example < RestModel
          id :different_name
        end
      end

      let(:field)   {:different_name}
      let(:options) {{id: true, validate: true}}

      it_behaves_like "a property"
      it_behaves_like "a key"
    end

    context "when it has options" do
      before do
        class Example < RestModel
          id some_option: 'some option value'
        end
      end

      let(:field)   {:id}
      let(:options) {{some_option: 'some option value', id: true, validate: true}}

      it_behaves_like "a property"
      it_behaves_like "a key"
    end

    context "when it has both different name and options" do
      before do
        class Example < RestModel
          id :different_name, some_option: 'some option value'
        end
      end

      let(:field)   {:different_name}
      let(:options) {{some_option: 'some option value', id: true, validate: true}}

      it_behaves_like "a property"
      it_behaves_like "a key"
    end

    context "when it defines somehow the option id: false" do
      before do
        class Example < RestModel
          id id: false
        end
      end

      let(:field)   {:id}
      let(:options) {{id: true, validate: true}}

      it_behaves_like "a property"
      it_behaves_like "a key"
    end
  end

  describe ".property" do
    context "when it is a normal property" do
      before do
        class Example < RestModel
          property :document_number, some_option: 'this is an option'
        end
      end

      let(:field)   {:document_number}
      let(:options) {{some_option: 'this is an option', validate: true}}

      it_behaves_like "a property"
    end

    context "when it has the option :id set to true" do
      before do
        class Example < RestModel
          property :document_number, id: true
        end
      end

      let(:field)   {:document_number}
      let(:options) {{id: true, validate: true}}

      it_behaves_like "a property"
      it_behaves_like "a key"
    end
  end

  describe ".properties" do
    before do
      class Example < RestModel
        properties :id, :description
        properties :price, :quantity, firstoption: 'this is the first option', secondoption: 'this is the second option'
      end
    end

    [:id, :description].each do |item|
      context "for #{item}" do
        let(:field)   {item}
        let(:options) {{validate: true}}

        it_behaves_like "a property"
      end
    end

    [:price, :quantity].each do |item|
      context "for #{item}" do
        let(:field)   {item}
        let(:options) {{firstoption: 'this is the first option', secondoption: 'this is the second option', validate: true}}

        it_behaves_like "a property"
      end
    end
  end
end
