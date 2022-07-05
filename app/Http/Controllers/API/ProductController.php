<?php

namespace App\Http\Controllers\API;

use App\Models\Product;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Validator;

class ProductController extends Controller
{
    //

    /* get all product details here */
    public function index()
    {
        $products = Product::all();
        return response()->json([
            'status' =>200,
            'products' => $products,
            ]);
    }

    /* fetch product details with the ID pass to the api route */

    public function edit($id)
    {
        $product = Product::find($id);
        if($product)
        {
            return response()->json([
                'status' =>200,
                'product' => $product,
                ]);
        }
        else
        {
            return response()->json([
                'status' =>404,
                'message' => 'No product found.',
                ]);
        }
    }

    /* function to save product details */
    public function store(Request $request)
    {

        $validator = Validator::make($request->all(),[
            'category_id' => 'required|max:191',
            'slug' => 'required|max:191',
            'name' => 'required|max:191',
            'meta_tile' => 'required|max:191',
            'brand' => 'required|max:20',
            'selling_price' => 'required|max:20',
            'original_price' => 'required|max:20',
            'qty' => 'required|max:4',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
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
            $product = new Product();
            $product->category_id = $request->input('category_id');
            $product->slug = $request->input('slug');
            $product->name = $request->input('name');
            $product->description = $request->input('description');

            $product->meta_tile = $request->input('meta_tile');
            $product->meta_keyword = $request->input('meta_keyword');
            $product->meta_descrip = $request->input('meta_descrip');

            $product->brand = $request->input('brand');
            $product->selling_price = $request->input('selling_price');
            $product->original_price = $request->input('original_price');
            $product->qty = $request->input('qty');

            /* this check if there is an image the uploade or do not process */
            if($request->hasFile('image'))
            {
                $file = $request->file('image');
                $extension = $file->getClientOriginalExtension();
                $filename = time().'.'.$extension;
                $file->move('uploads/product_image/', $filename);
                $product->image = 'uploads/product_image/'.$filename;
            }
            /* ends here */
            $product->featured = $request->input('featured');
            $product->popular = $request->input('popular') ;
            $product->status = $request->input('status');

            $product->save();

            if($product->save())
            {
            return response()->json([
                 'status' =>200,
                 'message' => 'Product Added Successfully.',
                ]);
            }
            else
            {
                return response()->json([
                    'status' =>403,
                    'message' => 'Product Not Save! Try Again.',
                   ]);
            }
        }
    }

    /* update function goes here */

    public function update(Request $request, $id)
    {

        $validator = Validator::make($request->all(),[
            'category_id' => 'required|max:191',
            'slug' => 'required|max:191',
            'name' => 'required|max:191',
            'meta_tile' => 'required|max:191',
            'brand' => 'required|max:20',
            'selling_price' => 'required|max:20',
            'original_price' => 'required|max:20',
            'qty' => 'required|max:4'

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
            $product = Product::find($id);

            if($product)
            {
                $product->category_id = $request->input('category_id');
                $product->slug = $request->input('slug');
                $product->name = $request->input('name');
                $product->description = $request->input('description');

                $product->meta_tile = $request->input('meta_tile');
                $product->meta_keyword = $request->input('meta_keyword');
                $product->meta_descrip = $request->input('meta_descrip');

                $product->brand = $request->input('brand');
                $product->selling_price = $request->input('selling_price');
                $product->original_price = $request->input('original_price');
                $product->qty = $request->input('qty');

                /* this check if there is an image the uploade or do not process */
                if($request->hasFile('image'))
                {
                    /* check if the previous image exist then delete before uplaoding new one */
                    $path = $product->image; // this image colunm already have the image path in the database
                    if(File::exists($path))
                    {
                        File::delete($path);
                    }
                    /* image deleting ends here --*/

                    $file = $request->file('image');
                    $extension = $file->getClientOriginalExtension();
                    $filename = time().'.'.$extension;
                    $file->move('uploads/product_image/', $filename);
                    $product->image = 'uploads/product_image/'.$filename;
                }
                /* ends here */
                $product->featured = $request->input('featured');
                $product->popular = $request->input('popular');
                $product->status = $request->input('status');

                $product->update();
                return response()->json([
                    'status' =>200,
                    'message' => 'Product Updated Successfully.',
                    ]);
             }
                else
                {
                    return response()->json([
                        'status' =>404,
                        'message' => 'Product Not found.',
                    ]);
                }
        }

    }
}
