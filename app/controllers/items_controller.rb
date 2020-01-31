class ItemsController < ApplicationController

    before_action :item_find , only: [:show,:update,:edit,:destroy]

    def index
        @items=Item.all.order("created_at DESC")
    end

    def new
        @item=Item.new
    end

    def show
    end

    def edit
    end

    def update
        if @item.update(item_params)
            redirect_to item_path(@item)
        else
            render edit_item_path(@item) 
        end
    end

    def destroy
        @item.destroy
        redirect_to root_path
    end

    def create
        @item=Item.new(item_params)
        if @item.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    private
     def item_params
        params.require(:item).permit(:title,:description)
     end

     def item_find
        @item=Item.find(params[:id])
     end
end
