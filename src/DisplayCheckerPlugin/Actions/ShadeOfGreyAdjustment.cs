namespace Loupedeck.DisplayCheckerPlugin.Actions;

public class ShadeOfGreyAdjustment() : PluginDynamicAdjustment(
	displayName: "Shade of grey",
	description: "Changes the shade of grey",
	groupName: "Adjustments",
	hasReset: true
)
{
	private int _value;

	protected override void ApplyAdjustment(string actionParameter, int diff)
	{
		this._value = Math.Clamp(this._value + diff, 0, 255);
		this.AdjustmentValueChanged();
	}

	protected override void RunCommand(string actionParameter)
	{
		this._value = 0;
		this.AdjustmentValueChanged();
	}

	protected override string GetAdjustmentValue(string actionParameter) =>
		$"RGB({this._value},{this._value},{this._value})";

	protected override BitmapImage GetAdjustmentImage(string actionParameter, PluginImageSize imageSize)
	{
		using var bitmapBuilder = new BitmapBuilder(imageSize);

		bitmapBuilder.FillRectangle(
			0,
			0,
			bitmapBuilder.Width,
			bitmapBuilder.Height,
			new BitmapColor(this._value, this._value, this._value)
		);

		return bitmapBuilder.ToImage();
	}
}
