namespace Loupedeck.DisplayCheckerPlugin.Actions;

public class ShadeOfGreyCommand : PluginDynamicCommand
{
	public ShadeOfGreyCommand()
	{
		for (var i = 0; i <= 255; i++)
		{
			var actionParameter = i.ToString();

			this.AddParameter(
				$"ShadeOfGrey{actionParameter}",
				$"RGB({actionParameter},{actionParameter},{actionParameter})",
				"Commands"
			);
		}
	}

	protected override void RunCommand(string actionParameter)
	{
	}

	protected override string GetCommandDisplayName(string actionParameter, PluginImageSize imageSize) =>
		!int.TryParse(actionParameter, out var value)
			? base.GetCommandDisplayName(actionParameter, imageSize)
			: $"RGB({value},{value},{value})";

	protected override BitmapImage GetCommandImage(string actionParameter, PluginImageSize imageSize)
	{
		if (!int.TryParse(actionParameter, out var value))
		{
			return base.GetCommandImage(actionParameter, imageSize);
		}

		using var bitmapBuilder = new BitmapBuilder(imageSize);

		bitmapBuilder.FillRectangle(
			0,
			0,
			bitmapBuilder.Width,
			bitmapBuilder.Height,
			new BitmapColor(value, value, value)
		);

		return bitmapBuilder.ToImage();
	}
}
