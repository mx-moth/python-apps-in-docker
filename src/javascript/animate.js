export default function animate() {
	let current = null;
	function animate(fn) {
		animate.stop();

		let schedule = () => {
			current = window.requestAnimationFrame(callback);
		};

		let callback = (now) => {
			fn(now);
			schedule();
		};

		schedule();
	}

	animate.stop = function() {
		if (current) {
			window.cancelAnimationFrame(current);
			current = null;
		}
	};

	return animate;
}
