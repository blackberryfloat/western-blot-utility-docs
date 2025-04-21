# Quantifying an Image

> **NOTE**  
> This assumes you have already opened the experiment as outlined in [Opening an Experiment](./open_an_experiment.md).

To quantify an image, select the relevant image in the explorer panel on the left. Images are listed under the **Data** collapsible header. Selecting an image will open it for annotation.

## Reference ROI Extrapolation

Currently, the application supports one proprietary quantification method called **Reference ROI Extrapolation**.

> **NOTE**  
> This is a heuristic algorithm designed to assist users, not automate the process. It may not always provide an ideal solution. It works best with clean images that are not skewed and have a clear distinction between background and foreground.

To use this method, start by drawing a rectangle around the relevant ROI on the far left. This is done via a click-and-drag process. When you release the mouse, the rectangle will be finalized, and all other ROIs will be automatically estimated. At this point, you can resize, move, add, or delete ROIs as needed. You can also restart the process using the undo pathway, the **Clear ROIs** button, or the **Clear Lanes** button. The right-side panel provides a quick snapshot of intensity values per lane/ROI and allows you to label controls.

> **NOTE**  
> Tight reference ROIs tend to yield the best results.

### Resize

All resize operations apply globally to all ROIs. Currently, the application does not support independently resizing individual ROIs. At the top of the right-side panel, you will find widgets for modifying the width and height of ROIs.

### Move (Translate)

To move an ROI, click and hold inside the ROI, then drag it to the desired position. For fine control over a specific ROI, hover over it to view the lane ID. In the right-side panel, you can use the fields under the associated lane header to adjust the x and y pixel positions of the ROI's top-left corner.

### Add

You can add an ROI at any time by clicking on the image. A new rectangle will be created at the cursor's position.

### Delete

To delete an ROI, right-click on it to open the context menu, then select **Delete**. Alternatively, you can use the **Del** button, but this will only remove the last ROI. If you need to restart, use the **Clear ROIs** button at the top of the right-side panel.

It is important to note that deleting an ROI is not the same as deleting a lane. To delete a lane, click the **Clear Lanes** button in the right-side panel or right-click the lane name in the side panel, then select **Remove Lane** from the context menu. Lanes and ROIs are handled separately so that lane metadata can be preserved as you manage ROIs. When ROIs are edited (except for deletion), they are automatically remapped to lanes to ensure the order of ROIs matches the order of lanes.

> **WARNING**  
> The independent control of ROIs and lanes is intentional but can lead to confusing behavior if not handled carefully. The most common issue is extra lanes with no associated ROIs. This can cause loading controls to be ignored, as they won't match the target lane count. To resolve this, remove the extra lanes when this occurs.
