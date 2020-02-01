class ItemsController < ApplicationController

    before_action :item_find , only: [:show,:update,:edit,:destroy]
    before_action :authenticate_user! , except: [:index]

    def index
        if user_signed_in?
            @items=Item.where(user_id: current_user.id).order("created_at DESC")
        end
    end

    def new
        @item=current_user.items.build
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
        @item=current_user.items.build(item_params)
        if @item.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def complete
        @item=Item.find(params[:id])
        @item.update_attribute(:completed_at,Time.now)
        redirect_to root_path , notice: "The item is completed successfully"
    end

    private
     def item_params
        params.require(:item).permit(:title,:description)
     end

     def item_find
        @item=Item.find(params[:id])
     end
end
