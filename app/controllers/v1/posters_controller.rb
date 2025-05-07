module V1
  class PostersController < V1::AccessController
    before_action :set_poster, only: :update
    def index
      authorize(Poster)
      posters = Poster.all
      render(json: posters, status: :ok, each_serializer: PosterSerializer)
    end

    def update
      authorize(@poster)
      @poster.update!(poster_params)
      render(json: @poster, status: :ok)
    end

    private

    def set_poster
      @poster = Poster.find(params[:id])
    end

    def poster_params
      permitted_attributes(Poster)
    end
  end
end
