document.addEventListener("DOMContentLoaded",() => {
	let input1 = document.querySelector("#input1");
	let input2 = document.querySelector("#input2");

 	document.querySelector("#clickem").addEventListener("click",(e) => {
		console.log('click');
		console.log('input1',input1.value);
		console.log('input2',input2.value);

		let num = parseInt(input1.value) + parseInt(input2.value);
		if (!isNaN(num)) {
		    document.querySelector("#result").innerText = 
			"" + num;
		} else {
		    document.querySelector("#result").innerText = 
			"NaN EECS 368"
		}
	    });
    });
