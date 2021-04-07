module Api
  module V1
    class MemesController < ApplicationController
      
      def index
        memes = Meme.all

        render json: MemeSerializer.new(memes, options).serialized.json
      end
      
      def show
        meme = Meme.find_by(slug: params[:slug])

        render json: MemeSerializer.new(meme, options).serialized.json
      end
      
      def create
        meme = Meme.new(meme_params)

        if airline.save
          render json: MemeSerializer.new(meme).serialized_json
        else
          render json: { error: meme.errors.messages }, status: 422
        end
      end
      
      def update
        meme = Meme.find_by(slug: params[:slug])

        if airline.update(meme_params)
          render json: MemeSerializer.new(meme, options).serialized_json
        else
          render json: { error: meme.errors.messages }, status: 422
        end
      end

      def destroy
        meme = Meme.find_by(slug: params[:slug])

        if meme.destroy
          head :no_content
        else
          render json: { error: meme.errors.messages }, status: 422
        end
      end

      private 

      def meme_params
        params.require(:meme).permit(:name, :image_url)
      end

      def options
        @options ||= {include: %i[reviews]}
      end

    end
  end
end