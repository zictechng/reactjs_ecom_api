<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Cart;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CheckoutController extends Controller
{
    //
    public function placeorder(Request $request)
    {
        if(auth('sanctum')->check())
        {
            $validator = Validator::make($request->all(),[
                'firstname' => 'required|max:191',
                'lastname' =>'required|max:191',
                'phone' => 'required|max:15',
                'email' => 'required|max:191',
                'address' => 'required|max:191',
                'city' => 'required|max:191',
                'state' => 'required|max:191',
                'zipcode' => 'required|max:10',
            ]);
            if($validator->fails())
            {
                return response()->json([
                    $errors = $validator->errors(),
                    'status' =>422,
                   // 'validator_err' => $validator->messages(),
                    'errors' => $errors,
                    ]);
            }
            else
            {
                $user_id = auth('sanctum')->user()->id;
                $order = new Order();
                $order->user_id = $user_id;
                $order->firstname = $request->firstname;
                $order->lastname = $request->lastname;
                $order->phone = $request->phone;
                $order->email = $request->email;
                $order->address = $request->address;
                $order->city = $request->city;
                $order->state = $request->state;
                $order->zipcode = $request->zipcode;

                $order->payment_mode = $request->payment_mode;
                $order->tracking_no = 'PID'.rand(111111,999999);
                $order->payment_id = $request->payment_id;
                $order->save();

                /* let get the order items and loop them to save them */
                $cart = Cart::where('user_id', $user_id)->get();
                $orderitems = [];
                foreach($cart as $item)
                {
                    $orderitems[] = [
                        'product_id' => $item->product_id,
                        'qty' =>$item->product_qty,
                        'price' => $item->product->selling_price,
                    ];
                 /* update the product table qty after placing order*/
                 $item->product->update([
                     'qty' => $item->product->qty - $item->product_qty,
                 ]);
                }
                /* create a relationship between order and orderitem table*/
               $order->orderitems()->createMany($orderitems);
               /* Empty the cart*/
               Cart::destroy($cart);

               return response()->json([
                    'status'=>200,
                    'message'=>'Order placed successfully',
                ]);
            }
        }
        else
        {
            return response()->json([
                'status'=>401,
                'message'=>'Please, login to continue',
            ]);
        }
    }

    public function validateOrder(Request $request)
    {
        if(auth('sanctum')->check())
        {
            $validator = Validator::make($request->all(),[
                'firstname' => 'required|max:191',
                'lastname' =>'required|max:191',
                'phone' => 'required|max:15',
                'email' => 'required|max:191',
                'address' => 'required|max:191',
                'city' => 'required|max:191',
                'state' => 'required|max:191',
                'zipcode' => 'required|max:10',
            ]);
            if($validator->fails())
            {
                return response()->json([
                    $errors = $validator->errors(),
                    'status' =>422,
                   // 'validator_err' => $validator->messages(),
                    'errors' => $errors,
                    ]);
            }
            else
            {
                return response()->json([
                    'status'=>200,
                    'message'=>'Form validated successfully',
                ]);
            }
        }
        else
        {
            return response()->json([
                'status'=>401,
                'message'=>'Please, login to continue',
            ]);
        }
    }
}
