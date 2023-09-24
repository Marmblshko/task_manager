require 'rails_helper'

RSpec.describe ReportsController do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:task) { create(:task, project:) }
  let(:report) { create(:report, task:) }
  let(:other_user) { create(:user) }

  before { sign_in user }

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new, params: { task_id: task.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new report' do
        expect do
          post :create, params: { task_id: task.id, report: attributes_for(:report) }
        end.to change(Report, :count).by(1)
      end

      it 'assigns the current user as the creator' do
        post :create, params: { task_id: task.id, report: attributes_for(:report) }
        expect(Report.last.creator_id).to eq(user.id)
      end

      it 'redirects to the task' do
        post :create, params: { task_id: task.id, report: attributes_for(:report) }
        expect(response).to redirect_to(task)
      end

      it 'sets a flash notice' do
        post :create, params: { task_id: task.id, report: attributes_for(:report) }
        expect(flash[:notice]).to eq('Report was successfully created.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new report' do
        expect do
          post :create, params: { task_id: task.id, report: attributes_for(:report, title: nil) }
        end.not_to change(Report, :count)
      end

      it 'renders the new template' do
        post :create, params: { task_id: task.id, report: attributes_for(:report, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { task_id: task.id, id: report.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the report' do
        new_title = 'Updated Report Title'
        put :update, params: { task_id: task.id, id: report.id, report: { title: new_title } }
        report.reload
        expect(report.title).to eq(new_title)
      end

      it 'redirects to the task' do
        put :update, params: { task_id: task.id, id: report.id, report: { title: 'Updated Title' } }
        expect(response).to redirect_to(task)
      end

      it 'sets a flash notice' do
        put :update, params: { task_id: task.id, id: report.id, report: { title: 'Updated Title' } }
        expect(flash[:notice]).to eq('Report was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the report' do
        original_title = report.title
        put :update, params: { task_id: task.id, id: report.id, report: { title: nil } }
        report.reload
        expect(report.title).to eq(original_title)
      end

      it 'renders the edit template' do
        put :update, params: { task_id: task.id, id: report.id, report: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the report' do
      report
      expect do
        delete :destroy, params: { task_id: task.id, id: report.id }
      end.to change(Report, :count).by(-1)
    end

    it 'redirects to the task' do
      delete :destroy, params: { task_id: task.id, id: report.id }
      expect(response).to redirect_to(task)
    end

    it 'sets a flash notice' do
      delete :destroy, params: { task_id: task.id, id: report.id }
      expect(flash[:notice]).to eq('Report was successfully destroyed.')
    end
  end
end
