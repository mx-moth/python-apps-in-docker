import bespoke from 'bespoke';
import classes from 'bespoke-classes';
import bullets from 'bespoke-bullets';
import touch from 'bespoke-touch';
import forms from 'bespoke-forms';
import keys from 'bespoke-keys';
import hash from 'bespoke-hash';

import { highlightBlock } from 'highlight.js';
console.log(highlightBlock);

function highlight(selector) {
	return function(deck) {
		deck.slides.forEach(function(slide) {
			console.log("Got a slide!", slide);
			for (let block of slide.querySelectorAll(selector)) {
				highlightBlock(block);
			}
		});
	};
}

var deck = bespoke.from('#slides', [
	classes(),
	bullets('.bullet'),
	keys(),
	touch(),
	hash(),
	forms(),
	highlight('.highlight'),
]);
