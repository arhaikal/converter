require "rails_helper"

RSpec.describe ExchangesController, :type => :controller do
  let!(:exchange)  { Exchange.create(amount: 100,
                                     base_currency: "EUR",
                                     target_currency: "USD",
                                     waiting_time: 1 ,
                                     user_id: user.id) }
  let!(:user) { User.create(email: "example@example.com",
                            password: "password") }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      sign_in(user)
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "does correct redirect" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

    it "loads all of the exchanges into @exchanges" do
      sign_in(user)
      get :index

      expect(assigns(:exchanges)).to match_array([exchange])
    end
  end

  describe "POST #new" do
    before { sign_in(user) }

     it "assigns @exchange" do
       get :new

       expect(assigns(:exchange)).to be_a_new(Exchange)
     end

     it "renders the new template" do
       get :new

       expect(response).to render_template("new")
     end
  end

  describe "POST 'create'" do
    context "when valid" do
      before_count = Exchange.count
      before { sign_in(user) }
      before { allow(controller).to receive(:current_user) { user } }
      before { post :create, params: { exchange: { amount: 100,
                                                   base_currency: "EUR",
                                                   target_currency: "USD",
                                                   waiting_time: 1} } }

      it "will redirect to root path" do
        expect(Exchange.count).not_to eq(before_count)
      end

    end

    context "when invalid" do
      before { sign_in(user) }
      before { allow(controller).to receive(:current_user) { user } }
      before { post :create, params: { exchange: {amount: 100,
                                       base_currency: "",
                                       target_currency: "USD",
                                       waiting_time: 1 } } }


      it "will render new template" do
        expect(response).to render_template("new")
      end

    end
  end

  describe "GET 'edit'" do
    before { sign_in(user) }
    before { get :edit, params: { id: exchange.id } }

    it "assigns @exchange" do
      expect(assigns(:exchange)).to eq(exchange)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end

  describe "PUT 'update'" do
   context "when success" do
     before { sign_in(user) }
     before { put :update, params: { exchange: { amount: 122 }, id: exchange.id } }

     it "will redirect to root path" do
       expect(response).to redirect_to exchange_path(exchange)
     end
   end

   context "when not success" do
     before{ sign_in(user) }
     before { put :update,  params: { exchange: { amount: "" }, id: exchange.id } }

     it "will render new template" do
       expect(response).to render_template("edit")
     end
   end
 end

  describe "DELETE 'destroy'" do
    before { sign_in(user) }
    before { delete :destroy, params: { id: exchange.id } }

    it "deletes that record" do
      expect(Exchange.where(id: exchange.id).count).to eq(0)
    end

    it "redirects to root path" do
      expect(response).to redirect_to exchanges_path
    end
  end
end
