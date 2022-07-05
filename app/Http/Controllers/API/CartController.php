<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Product;
use Illuminate\Http\Request;

class CartController extends Controller
{
    //
    public function addtocart(Request $request)
    {
        if(auth('sanctum')->check())
        {
            $user_id = auth('sanctum')->user()->id;
            $product_id = $request->product_id;
            $product_qty = $request->product_qty;
            /* empty quantity error */
            if(empty($product_qty))
            {
                return response()->json([
                    'status'=>500,
                    'message'=>'Please, select product quantity',
                ]);
            }
            /* empty quantity error ends here */

            $productCheck = Product::where('id', $product_id)->first();

            if($productCheck)
            {
                /* check cart table if this user have added the same product already */
                if(Cart::where('product_id', $product_id)->where('user_id', $user_id)->exists())
                {
                    return response()->json([
                        'status'=>409,
                        'message'=> $productCheck->name. ' Product already added to cart',
                    ]);
                }
                else
                {
                    /* now save user product to cart table here */
                    $cart_item = new Cart();
                    $cart_item->user_id = $user_id;
                    $cart_item->product_id = $product_id;
                    $cart_item->product_qty = $product_qty;
                    $cart_item->save();

                    return response()->json([
                        'status'=>201,
                        'message'=>'Added to cart',
                    ]);
                }
               /* saving item to cart ends here */
            }
            else
            {
                return response()->json([
                    'status'=>404,
                    'message'=>'Product not found',
                ]);
            }

        }
        else
        {
            return response()->json([
                'status'=>401,
                'message'=> 'Login to add to cart',
            ]);
        }
    }

    /* function to get/view user cart details */

    public function viewcart()
    {
        if(auth('sanctum')->check())
        {
            $user_id = auth('sanctum')->user()->id;
            $cartItems = Cart::where('user_id', $user_id)->get();
            return response()->json([
                'status'=>200,
                'cart'=> $cartItems,
            ]);
        }
        else
        {
            return response()->json([
                'status'=>401,
                'message'=> 'Login to view cart data',
            ]);
        }
    }

    /* function to update quantity directly inside the db from front end request */

    public function updatequantity($cart_id, $scope)
    {
        if(auth('sanctum')->check())
        {
            $user_id = auth('sanctum')->user()->id;
            $cartitem = Cart::where('id', $cart_id)->where('user_id', $user_id)->first();
            if($scope == "inc")
            {
                $cartitem->product_qty += 1;
            }
            else if($scope == "dec")
            {
                $cartitem->product_qty -= 1;
            }
                $cartitem->update();
                return response()->json([
                    'status'=>200,
                    'message'=> 'Product Quantity updated',
                ]);
        }
        else
        {
            return response()->json([
                'status'=>401,
                'message'=> 'Login to continue',
            ]);
        }
    }

    /* delete from cart */
    public function deleteCartitem($cart_id)
    {
        if(auth('sanctum')->check())
        {
            $user_id = auth('sanctum')->user()->id;
            $cartitem = Cart::where('id', $cart_id)->where('user_id', $user_id)->first();
            if($cartitem)
            {
                $cartitem->delete();
                return response()->json([
                    'status'=>200,
                    'message'=> 'Cart Item removed successfully',
                ]);
            }
            else
            {
                return response()->json([
                    'status'=>404,
                    'message'=> ' Cart item not found',
                ]);
            }
            return response()->json([
                'status'=>401,
                'message'=> 'Login to continue',
            ]);
        }
        else
        {


            return response()->json([
                'status'=>401,
                'message'=> 'Login to continue',
            ]);
        }
    }
}
