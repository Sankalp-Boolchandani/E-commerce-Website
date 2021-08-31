function add_to_cart(pid, pname, price){
    let cart=localStorage.getItem("cart");
    if (cart==null){
        // no cart yet
        let products=[];
        let product={productId:pid, productName:pname, productPrice:price, productQuantity:1};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        //console.log("product is added for the first time")
        showToast("Item is added to the cart")
    }else{
        // cart already exists
        let pcart=JSON.parse(cart);
        let oldProduct=pcart.find((item)=>item.productId==pid)
        if (oldProduct){
            // product already exists in the cart, increasing quantity
            oldProduct.productQuantity=oldProduct.productQuantity+1
            pcart.map((item)=>{
                if (item.productId==oldProduct.productId){
                    item.productQuantity=oldProduct.productQuantity
                }
            })
            localStorage.setItem("cart", JSON.stringify(pcart))
            //console.log("product quantity increased")
            showToast(oldProduct.productName+" quantity increased to "+oldProduct.productQuantity)
        } else {
            // add new product to the cart
            let productn={productId:pid, productName:pname, productPrice:price, productQuantity:1};
            pcart.push(productn)
            localStorage.setItem("cart", JSON.stringify(pcart))
            console.log("product is added")
            showToast("product is added to the cart")
        }
    }
    updateCart();
}

function updateCart(){
    let cartStr=localStorage.getItem("cart")
    let cart=JSON.parse(cartStr)
    if (cart==null || cart.length==0){
        console.log("cart is empty !")
        $(".cart-items").html("(0)");
        $(".cart-body").html("<h3>Cart is Empty</h3>")
        $(".check-out-btn").attr('disabled', true);
    }else{
        // cart is not empty
        console.log(cart)
        $(".cart-items").html(`(${cart.length})`);
        let table=`
        <table class='table'>
        <thead class='thead-light'>
        <tr>
        <th>Item Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total Price</th>
        <th>Action</th>
        </tr>
        </thead>
        `;

        let totalPrice=0;

        cart.map((item)=>{
            table+=`
            <tr>
            <td>${item.productName}</td>
            <td>${item.productPrice}</td>
            <td>${item.productQuantity}</td>
            <td>${item.productQuantity*item.productPrice}</td>
            <td> <button onclick="deleteItemFromCart(${item.productId})" class='btn btn-danger btn-sm'>Remove</button> </td>
            </tr>
            `;
            totalPrice+=item.productQuantity*item.productPrice;
        })


        table=table + `
        <tr><td colspan='5' class='text-right font-weight-bold m-5'> Total Price : ${totalPrice} </td></tr>
        </table>`;
        $(".cart-body").html(table)
        $(".check-out-btn").attr('disabled', false);
    }
}

// deleting Item
function deleteItemFromCart(pid){
    let cart=JSON.parse(localStorage.getItem("cart"))
    let new_cart=cart.filter((item)=>item.productId!=pid)
    localStorage.setItem("cart",JSON.stringify(new_cart))
    updateCart();
    showToast("Item removed from the cart")
}


$(document).ready(function (){
    updateCart()
})

function showToast(content){
     $('#toast').addClass("display");
     $('#toast').html(content)
     setTimeout(()=>{
         $('#toast').removeClass("display");
     }, 2000)
}

function goToCheckout(){
    window.location="checkout.jsp";
}