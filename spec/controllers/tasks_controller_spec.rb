require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:task) { create(:task) }

  before { sign_in user }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new task' do
        expect {
          post :create, params: { task: attributes_for(:task, project_id: project.id) }
        }.to change(Task, :count).by(1)
      end

      it 'assigns the current user as the creator' do
        post :create, params: { task: attributes_for(:task, project_id: project.id) }
        expect(Task.last.creator_id).to eq(user.id)
      end

      it 'redirects to the task' do
        post :create, params: { task: attributes_for(:task, project_id: project.id) }
        expect(response).to redirect_to(Task.last)
      end

      it 'sets a flash notice' do
        post :create, params: { task: attributes_for(:task, project_id: project.id) }
        expect(flash[:notice]).to eq("Task was successfully created.")
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new task' do
        expect {
          post :create, params: { task: attributes_for(:task, project_id: project.id, title: nil) }
        }.not_to change(Task, :count)
      end

      it 'renders the new template' do
        post :create, params: { task: attributes_for(:task, project_id: project.id, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: task.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: task.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the task' do
        new_title = 'Updated Task Title'
        put :update, params: { id: task.id, task: { title: new_title } }
        task.reload
        expect(task.title).to eq(new_title)
      end

      it 'redirects to the task' do
        put :update, params: { id: task.id, task: { title: 'Updated Title' } }
        expect(response).to redirect_to(task)
      end

      it 'sets a flash notice' do
        put :update, params: { id: task.id, task: { title: 'Updated Title' } }
        expect(flash[:notice]).to eq("Task was successfully updated.")
      end
    end

    context 'with invalid parameters' do
      it 'does not update the task' do
        original_title = task.title
        put :update, params: { id: task.id, task: { title: nil } }
        task.reload
        expect(task.title).to eq(original_title)
      end

      it 'renders the edit template' do
        put :update, params: { id: task.id, task: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the task' do
      task
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end

    it 'redirects to the tasks path' do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(tasks_path)
    end

    it 'sets a flash notice' do
      delete :destroy, params: { id: task.id }
      expect(flash[:notice]).to eq("Task was successfully destroyed.")
    end
  end
end
