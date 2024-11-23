require 'rails_helper'

RSpec.describe "/api/v1/tasks", type: :request do
  let(:valid_attributes) do
    {
      name: 'Valid Task Name',
      finished: false
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      finished: nil
    }
  end

  let(:valid_headers) do
    {}
  end

  describe "GET /index" do
    it "renders a successful response" do
      Api::V1::Task.create! valid_attributes
      get api_v1_tasks_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = Api::V1::Task.create! valid_attributes
      get api_v1_task_url(task), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Api::V1::Task" do
        expect do
          post api_v1_tasks_url,
               params: { api_v1_task: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Api::V1::Task, :count).by(1)
      end

      it "renders a JSON response with the new api_v1_task" do
        post api_v1_tasks_url,
             params: { api_v1_task: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Api::V1::Task" do
        expect do
          post api_v1_tasks_url,
               params: { api_v1_task: invalid_attributes }, as: :json
        end.to change(Api::V1::Task, :count).by(0)
      end

      it "renders a JSON response with errors for the new api_v1_task" do
        post api_v1_tasks_url,
             params: { api_v1_task: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        skip("Add a hash of attributes valid for your model")
      end

      it "updates the requested api_v1_task" do
        task = Api::V1::Task.create! valid_attributes
        patch api_v1_task_url(task),
              params: { api_v1_task: new_attributes }, headers: valid_headers, as: :json
        task.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the api_v1_task" do
        task = Api::V1::Task.create! valid_attributes
        patch api_v1_task_url(task),
              params: { api_v1_task: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the api_v1_task" do
        task = Api::V1::Task.create! valid_attributes
        patch api_v1_task_url(task),
              params: { api_v1_task: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested api_v1_task" do
      task = Api::V1::Task.create! valid_attributes
      expect do
        delete api_v1_task_url(task), headers: valid_headers, as: :json
      end.to change(Api::V1::Task, :count).by(-1)
    end
  end
end
