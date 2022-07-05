<?php

namespace App\Models;

use App\Models\Category;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Product extends Model
{
    use HasFactory;
    protected $table = 'products';
    protected $fillable = [
        'category_id',
        'meta_tile',
        'meta_keyword',
        'meta_descrip',
        'slug',
        'name',
        'description',
        'brand',
        'selling_price',
        'original_price',
        'qty',
        'image',
        'featured',
        'popular',
        'status',
    ];
    /* this will create a database relationship between category
    /* and product table */

    protected $with = ['category'];  // this will pass it to javascript, jquery or any other programming platform outside laravel
    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id', 'id'); // this is for normal laravel format
    }
    /* category_id is the id in the product table, id is the id in category table
    /* so we are much both together here to fetch the actual name */
}
