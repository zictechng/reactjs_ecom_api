<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    use HasFactory;
    protected $table = 'carts';
    protected $fillable = [
        'user_id',
        'product_id',
        'product_qty',
    ];
    /* create a db table relationship for cart and product table */

    protected $with = ['product']; // this will help to use the relationship value in reactjs or javascript application.
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id'); // 'product_id' : is the ID in cart table, why 'id' is the id in product table
    }
}
