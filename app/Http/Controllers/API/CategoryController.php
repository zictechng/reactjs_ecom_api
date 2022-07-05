<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CategoryController extends Controller
{
    /*  get all the category from the database and send result to frontend view json */
    public function index()
    {
        $category = Category::all();
        return response()->json([
            'status' => 200,
            'category'=>$category,
        ]);
    }

    /* this will fetch data of category id pass to the controller view the api with the ID send */
    public function edit($id)
    {
        $category = Category::find($id);
        if($category)
        {
            return response()->json([
                'status'=>200,
                'category'=> $category,
            ]);
        }
        else
        {
            return response()->json([
                'status' => 404,
                'message'=> 'No category found',
            ]);
        }
    }
    //

    /* this will update the rcord from the ID send fron the api */
    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(),[
            'meta_tile' => 'required|max:191',
            'slug' =>'required|max:191',
            'name' => 'required|max:191',
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
            $category = Category::find($id);
            if($category)
            {
                $category->meta_tile = $request->input('meta_tile');
                $category->meta_keyword = $request->input('meta_keyword');
                $category->meta_descrip = $request->input('meta_descrip');
                $category->slug = $request->input('slug');
                $category->name = $request->input('name');
                $category->description = $request->input('description');
                $category->status = $request->input('status') == true ? '1': '0';
                $category->save();
                return response()->json([
                    'status' => 200,
                    'message' => 'Category Updated Successfully.',
                ]);
            }
            else
            {
                return response()->json([
                    'status' => 404,
                    'message' => 'No record ID found.',
                ]);
            }
        }
    }


    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'meta_tile' => 'required|max:191',
            'slug' =>'required|max:191',
            'name' => 'required|max:191',
        ]);
        if($validator->fails())
        {
            return response()->json([
                $errors = $validator->errors(),
                'status' =>400,
               // 'validator_err' => $validator->messages(),
                'errors' => $errors,
                ]);
        }
        else
        {
            $category = new Category;
            $category->meta_tile = $request->input('meta_tile');
            $category->meta_keyword = $request->input('meta_keyword');
            $category->meta_descrip = $request->input('meta_descrip');
            $category->slug = $request->input('slug');
            $category->name = $request->input('name');
            $category->description = $request->input('description');
            $category->status = $request->input('status') == true ? '1': '0';
            $category->save();
            return response()->json([
                'status' => 200,
                'message' => 'Category Added Successfully.',
            ]);
        }

    }

    /* get all cetrgory and send to select category fontend via api call */
    public function allcategory()
    {
        $category = Category::where('status', '0')->get();
        return response()->json([
            'status' => 200,
            'category' => $category,
        ]);
    }

    /* delete reguest function comes here */
    public function delete($id)
    {
        $category = Category::find($id);
        if($category)
        {
           $category->delete();

            return response()->json([
                'status' => 200,
                'message' => 'Category Deleted Successfully.',
            ]);
        }
        else
        {
            return response()->json([
                'status' => 404,
                'message' => 'No Category ID Found.',
            ]);
        }

    }
}
