<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    //
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name'=> 'required|max:191',
            'email'=>'required|email|max:191|unique:users,email,id',
            'phone'=> 'required|max:11',
            'password' => 'required|min:8',
        ]);
        if($validator->fails())
        {
            return response()->json([
                $errors = $validator->errors(),
               // 'validator_err' => $validator->messages(),
                'validation_errors' => $errors,
                ]);
        }
        else
        {
            $user = User::create([
                'name' => $request->name,
                'phone' => $request->phone,
                'email' => $request->email,
                'password' => Hash::make($request->password),
            ]);
            $token = $user->createToken($user->email .'_token')->plainTextToken;
            return response()->json([
                'status' =>200,
                'username' =>$user->name,
                'token' =>$token,
                'message' =>'Registration Successfully.',
            ]);
        }
    }

    /* create login function here */
    public function login(Request $request)
    {
        /* validate details here */
        $validator = Validator::make($request->all(), [

            'email'=>'required|email|max:191',
            'password' => 'required|min:8',
        ]);
        if($validator->fails())
        {
            return response()->json([
                $errors = $validator->errors(),
               // 'validator_err' => $validator->messages(),
                'validation_errors' => $errors,
                ]);
        }
        else
        {
            $user = User::where('email', $request->email)->first();
            if(! $user || ! Hash::check($request->password, $user->password))
            {
                return response()->json([
                   'status' => 401,
                   // 'validator_err' => $validator->messages(),
                    'message' => 'Invalid Credentials',
                    ]);
                // throw ValidationException::withMessages([
                //     'email' => ['The provided credentials are incorrect.'],
                // ]);
            }
            else
            {
                /* this will help check user role permission */
                if($user->role_as == 1) // 1= admin, 0 = normal user
                {
                    $role = 'admin';
                    $token = $user->createToken($user->email.'_AdminToken', ['server:admin'])->plainTextToken;
                }
                else
                {
                    $role = '';
                    $token = $user->createToken($user->email.'_Token', [''])->plainTextToken;
                }
                /* ends here */

                return response()->json([
                    'status' => 200,
                    'username' => $user->name,
                    'token' => $token,
                     'message' => 'Logged In Successful.',
                     'role' => $user->role_as,
                     ]);
            }
        }
    }

    public function logout()
    {
        auth()->user()->tokens()->delete();
        return response()->json([
            'status' =>200,
            'message'=>'Logged Out Successfully!'
        ]);
    }
}
