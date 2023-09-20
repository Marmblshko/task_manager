require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @projects to all projects when user is an admin' do
      admin_user = create(:user, :admin)
      sign_in admin_user

      project1 = create(:project)
      project2 = create(:project)

      get :index

      expect(assigns(:projects)).to include(project1, project2)
    end

    it 'assigns @projects to user-specific projects when user is not an admin' do
      user = create(:user)
      sign_in user

      project1 = create(:project, creator_id: user.id, users_in_project: [user.id])
      project2 = create(:project)
      project3 = create(:project, users_in_project: [user.id])

      get :index

      expect(assigns(:projects)).to include(project1, project3)
      expect(assigns(:projects)).not_to include(project2)
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
      it 'creates a new project' do
        expect {
          post :create, params: { project: attributes_for(:project) }
        }.to change(Project, :count).by(1)
      end

      it 'assigns the current user as the creator' do
        post :create, params: { project: attributes_for(:project) }
        expect(Project.last.creator_id).to eq(user.id)
      end

      it 'redirects to the projects path' do
        post :create, params: { project: attributes_for(:project) }
        expect(response).to redirect_to(projects_path)
      end

      it 'sets a flash notice' do
        post :create, params: { project: attributes_for(:project) }
        expect(flash[:notice]).to eq("Project was successfully created.")
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new project' do
        expect {
          post :create, params: { project: attributes_for(:project, title: nil) }
        }.not_to change(Project, :count)
      end

      it 'renders the new template' do
        post :create, params: { project: attributes_for(:project, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do

    let(:project) { create(:project) }

    it 'returns a successful response' do
      get :show, params: { id: project.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    let(:project) { create(:project, creator_id: user.id) }

    it 'returns a successful response' do
      get :edit, params: { id: project.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let(:project) { create(:project, creator_id: user.id) }

    context 'with valid parameters' do
      it 'updates the project' do
        new_title = 'Updated Project Title'
        put :update, params: { id: project.id, project: { title: new_title } }
        project.reload
        expect(project.title).to eq(new_title)
      end

      it 'redirects to the project' do
        put :update, params: { id: project.id, project: { title: 'Updated Title' } }
        expect(response).to redirect_to(project)
      end

      it 'sets a flash notice' do
        put :update, params: { id: project.id, project: { title: 'Updated Title' } }
        expect(flash[:notice]).to eq("Project was successfully updated.")
      end
    end

    context 'with invalid parameters' do
      it 'does not update the project' do
        original_title = project.title
        put :update, params: { id: project.id, project: { title: nil } }
        project.reload
        expect(project.title).to eq(original_title)
      end

      it 'renders the edit template' do
        put :update, params: { id: project.id, project: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:project) { create(:project, creator_id: user.id) }

    it 'destroys the project' do
      project
      expect {
        delete :destroy, params: { id: project.id }
      }.to change(Project, :count).by(-1)
    end

    it 'redirects to the projects path' do
      delete :destroy, params: { id: project.id }
      expect(response).to redirect_to(projects_path)
    end

    it 'sets a flash notice' do
      delete :destroy, params: { id: project.id }
      expect(flash[:notice]).to eq("Project was successfully destroyed.")
    end
  end
end
